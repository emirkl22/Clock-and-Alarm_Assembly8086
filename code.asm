org 100h

#start=Emulation_Kit.exe# ; Starting Emulation_Kit.exe for simulate 7 segment display   

; Giving first value

mov bh, 0 ; HOUR
mov bl, 0 ; MINUTE
mov 1000h, 0 ; SECOND


program:

   mov al,  byte ptr[1000h] ;move second value to AL register, because we can not increament with memory
   inc al ; second+1
   mov  byte ptr[1000h],al ;giving back second's value after increament

   
   ; value 60 checking for second
   
   cmp al, 60 ; in above we were gave second's valu to al so we can continue using al for checking 
   mov al,0 ; make AL register zero
   jne minute_check ; if not equal jump to minute checking part

   mov 1000h, 0 ; if second equal to 60, make its value 0
   inc bl ; and increase the minute

   ; value 60 checking for minute
   minute_check:

   cmp bl, 60 ; check the minute's value for equal to 60
   jne continue ; if not equal to 60 go to continue label

   mov bl, 0 ; if minute is 60, make its value 0
   inc bh ; and increase the hours


continue:

   
   ;Alarm System    
    
    ; Setting the alarm's value
    mov byte ptr[1200h], 0      ; Set alarm hour to 0 hours
    mov byte ptr[1201h] , 10      ; Set alarm minute to 10 minutes

    ; Check Alarm with current time
    cmp bh, byte ptr[1200h]      ; Compare alarm hour with current hour
    jne not_time    ; Jump if not equal (alarm time not reached)
    cmp bl, byte ptr[1201h]      ; Compare alarm minute with current minute
    jne not_time    ; Jump if not equal (alarm time not reached)
    
    ; If Alarm time == current time display alarm message  
    
    ; set video mode    
    mov ax, 3     ; text mode 80x25, 16 colors, 8 pages (ah=0, al=3)
    int 10h         
    
    ; set segment register:
    mov     ax, 0b800h
    mov     ds, ax
    
    ; print "Alarm!"
    
    mov [00h], 'A'
    
    mov [02h], 'l'
    
    mov [04h], 'a'
    
    mov [06h], 'r'
    
    mov [08h], 'm'
    
    mov [0ah], '!'
    
    ; wait for any key press:
    mov ah, 0
    int 16h   
    
    ret
    

; if alarm time not reached loop continue to here
not_time:   


   mov ax, 0  ; clear ax beacuse we use it
   mov cl, 10 ; make cl register 10 for multiple divisions

   ; Display Clock
   
   ; Display first part of the hour
   mov al, bh ; get hour's value
   div cl ; div ax to cl (10)
   mov ah, 0  ;clear ah register
   mov si, ax ; set ax to si
   mov al, numbers[si] ; get value from numbers array

   mov dx, 2030h ;first display port for 7 segment display
   out dx, al ; Show value in this port

   mov ax, 0 ;clear ax register

    ; Display second part of the hour
   mov al, bh ; get hour's value
   div cl  ; div ax to cl (10)
   mov al, ah ; get the rest part
   mov ah, 0 ;clear ah register
   mov si, ax ;set ax to si
   mov al, numbers[si]; get value from numbers array

   mov dx, 2031h ;second display port for 7 segment display
   out dx, al ; Show value in this port

   mov ax, 0 ; clear ax register

   ; display - between hour and minute
   mov al, numbers[10]; get value from numbers array for display - symbol
   mov dx, 2032h ;third display port for 7 segment display
   out dx, al ;display - on the 7 segment display 

   ; Display Minute
   ; Display first part of minute
   mov al, bl ; get minut's value
   div cl  ; div ax to cl (10)
   mov ah, 0
   mov si, ax
   mov al, numbers[si] ; get value from numbers array

   mov dx, 2033h ;fourth display port for 7 segment display
   out dx, al ; Show value in this port

   mov ax, 0 ; clear ax register

   ; Display second part of minute
   mov al, bl ; get minut's value
   div cl  ; div ax to cl (10)
   mov al, ah ; get the rest part
   mov ah, 0 ;clear ah register
   mov si, ax ;set ax to si
   mov al, numbers[si] ; get value from numbers array

   mov dx, 2034h ;fifth display port for 7 segment display
   out dx, al  ; Show value in this port

   mov ax, 0  ; clear ax register

   ; display - between minute and second
   mov al, numbers[10] ; get value from numbers array for display - symbol
   mov dx, 2035h ;sixth display port for 7 segment display
   out dx, al ;display - on the 7 segment display 

   ; Display Second
   ; Display first part of second
   mov al, byte ptr[1000h]  ; get second's value
   div cl  ; div ax to cl (10)
   mov ah, 0  ;clear ah register
   mov si, ax ; set ax to si
   mov al, numbers[si] ; get value from numbers array

   mov dx, 2036h ;seventh display port for 7 segment display
   out dx, al ; Show value in this port

   mov ax, 0 ; clear ax register

   ; Display second part of second
   mov al,  byte ptr[1000h]  ; get second's value
   div cl  ; div ax to cl (10)
   mov al, ah ; get the rest part
   mov ah, 0 ; clear ah register
   mov si, ax ; set ax to si
   mov al, numbers[si] ; get value from numbers array

   mov dx, 2037h ;sizth display port for 7 segment display
   out dx, al ; Show value in this port

   mov ax, 0 ; clear ax register

   loop program ; continue the loop for update time 

ret

; number array for 7 segment display

;              0          1          2          3          4          5          6          7          8          9          - 
numbers db 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b, 01000000b
