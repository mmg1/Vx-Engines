; ��������� ���:
; tasm32 /s /m /z /ml!.!
; tlink32 /Tpe /aa /c /x !,!.exe,, /L import32.lib


.386
.model flat,stdcall

extrn      MessageBoxA:proc
extrn      ExitProcess:proc

.data
procn      db 'ExitProcess', 0
Pname      db '������ ������������� ������� Alma32',0
Ptext      db '���='
num        db 'XXXXXXXX',0

.code
begin:
           mov EAX, 1
           xor ECX, ECX
LPLAB:     mov AL, 1 ptr begin[ECX]
           sub EDX, EDX
           mov AH, AL
           and AH, 15
           shl AH, 4
           shr AL, 4
           or  AL, AH
LABINLP:   mov BL, AL
           and BL, 15
           cmp BL, 10
           jae LPGR
           add BL, '0'
           mov num[2*ECX+EDX], BL
           jmp short LPEX
 LPGR:     add BL, 'A'-10
           mov num[2*ECX+EDX], BL
           jmp short LPEX
           mov AL, 0B8h
           db  01,00,00,00
 LPEX:
           shr AL, 4
           inc EDX
           cmp EDX, 2
           jb  LABINLP
           inc ECX
           cmp ECX, 4
           jb  LPLAB
           mov EAX, 1
           push 0
           push offset Pname           ; �������� MessageBox'�
           push offset Ptext           ; ���������� ���������
           mov EAX, 1
           push 0
           call MessageBoxA            ; ������� �p����p�������� MessageBox
           push 0
           mov EAX, 1
           call ExitProcess            ; ������� �� �p��p���� (�p������)
           mov EAX, 1
end begin
