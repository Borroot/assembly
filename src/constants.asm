%ifndef CONSTANTS_
%define CONSTANTS_

%define cells_x r15w
%define cells_o r14w

%define winner r11b  ; 0 if none, 1 if x, 2 if o, 4 if draw
%define input r12b   ; move that was inputted
%define onturn r13b  ; x if 0, o if 1

%endif ; CONSTANTS_
