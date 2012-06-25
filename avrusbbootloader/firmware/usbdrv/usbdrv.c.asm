GAS LISTING /tmp/ccGw9bPe.s 			page 1


   1               		.file	"usbdrv.c"
   2               	__SREG__ = 0x3f
   3               	__SP_H__ = 0x3e
   4               	__SP_L__ = 0x3d
   5               	__tmp_reg__ = 0
   6               	__zero_reg__ = 1
   7               		.global __do_copy_data
   8               		.global __do_clear_bss
   9               		.text
  10               	.global	usbInit
  11               		.type	usbInit, @function
  12               	usbInit:
  13               	/* prologue: frame size=0 */
  14               	/* prologue end (size=0) */
  15 0000 35B7      		in r19,85-0x20
  16 0002 3360      		ori r19,lo8(3)
  17 0004 35BF      		out 85-0x20,r19
  18 0006 2BB7      		in r18,91-0x20
  19 0008 2064      		ori r18,lo8(64)
  20 000a 2BBF      		out 91-0x20,r18
  21 000c 83EC      		ldi r24,lo8(-61)
  22 000e 8093 0000 		sts usbTxBuf1,r24
  23               	/* epilogue: frame size=0 */
  24 0012 0895      		ret
  25               	/* epilogue end (size=1) */
  26               	/* function usbInit size 10 (9) */
  27               		.size	usbInit, .-usbInit
  28               	.global	usbPoll
  29               		.type	usbPoll, @function
  30               	usbPoll:
  31               	/* prologue: frame size=0 */
  32 0014 0F93      		push r16
  33 0016 1F93      		push r17
  34 0018 CF93      		push r28
  35 001a DF93      		push r29
  36               	/* prologue end (size=4) */
  37 001c 9091 0000 		lds r25,usbRxLen
  38 0020 1916      		cp __zero_reg__,r25
  39 0022 04F4      		brge .L86
  40 0024 2091 0000 		lds r18,usbInputBufOffset
  41 0028 8091 0000 		lds r24,usbRxToken
  42 002c 8D32      		cpi r24,lo8(45)
  43 002e 01F0      		breq .L68
  44 0030 00E8      		ldi r16,lo8(-128)
  45 0032 0093 0000 		sts usbMsgFlags,r16
  46 0036 1092 0000 		sts usbMsgLen,__zero_reg__
  47               	.L90:
  48 003a 1092 0000 		sts usbRxLen,__zero_reg__
  49               	.L86:
  50 003e 1091 0000 		lds r17,usbTxLen
  51 0042 14FF      		sbrs r17,4
  52 0044 00C0      		rjmp .L44
  53 0046 8091 0000 		lds r24,usbMsgLen
  54 004a 8F3F      		cpi r24,lo8(-1)
  55 004c 01F0      		breq .L44
  56 004e 182F      		mov r17,r24
  57 0050 8930      		cpi r24,lo8(9)
GAS LISTING /tmp/ccGw9bPe.s 			page 2


  58 0052 00F0      		brlo .+2
  59 0054 00C0      		rjmp .L69
  60               	.L47:
  61 0056 811B      		sub r24,r17
  62 0058 8093 0000 		sts usbMsgLen,r24
  63 005c 8091 0000 		lds r24,usbMsgFlags
  64 0060 80FF      		sbrs r24,0
  65 0062 00C0      		rjmp .L48
  66 0064 03EC      		ldi r16,lo8(-61)
  67               	.L50:
  68 0066 8F5F      		subi r24,lo8(-(1))
  69 0068 8093 0000 		sts usbMsgFlags,r24
  70 006c 2091 0000 		lds r18,usbMsgPtr
  71 0070 3091 0000 		lds r19,(usbMsgPtr)+1
  72 0074 86FF      		sbrs r24,6
  73 0076 00C0      		rjmp .L70
  74 0078 912F      		mov r25,r17
  75 007a F901      		movw r30,r18
  76 007c A0E0      		ldi r26,lo8(usbTxBuf+1)
  77 007e B0E0      		ldi r27,hi8(usbTxBuf+1)
  78               	.L54:
  79 0080 9150      		subi r25,lo8(-(-1))
  80 0082 9F3F      		cpi r25,lo8(-1)
  81 0084 01F4      		brne .+2
  82 0086 00C0      		rjmp .L71
  83               	/* #APP */
  84 0088 4491      		lpm r20, Z
  85               		
  86               	/* #NOAPP */
  87 008a 4D93      		st X+,r20
  88 008c 3196      		adiw r30,1
  89 008e 00C0      		rjmp .L54
  90               	.L68:
  91 0090 3AE5      		ldi r19,lo8(90)
  92 0092 3093 0000 		sts usbTxLen,r19
  93 0096 9B30      		cpi r25,lo8(11)
  94 0098 01F0      		breq .L72
  95 009a 90E0      		ldi r25,lo8(0)
  96 009c 20E8      		ldi r18,lo8(-128)
  97               	.L41:
  98 009e 2093 0000 		sts usbMsgFlags,r18
  99 00a2 9093 0000 		sts usbMsgLen,r25
 100 00a6 00C0      		rjmp .L90
 101               	.L44:
 102 00a8 9AE0      		ldi r25,lo8(10)
 103               	.L62:
 104 00aa 20B3      		in r18,48-0x20
 105 00ac 2C70      		andi r18,lo8(12)
 106 00ae 01F0      		breq .+2
 107 00b0 00C0      		rjmp .L66
 108 00b2 9150      		subi r25,lo8(-(-1))
 109 00b4 01F4      		brne .L62
 110 00b6 1092 0000 		sts usbNewDeviceAddr,__zero_reg__
 111 00ba 1092 0000 		sts usbDeviceAddr,__zero_reg__
 112 00be 00C0      		rjmp .L66
 113               	.L72:
 114 00c0 C0E0      		ldi r28,lo8(usbRxBuf+12)
GAS LISTING /tmp/ccGw9bPe.s 			page 3


 115 00c2 D0E0      		ldi r29,hi8(usbRxBuf+12)
 116 00c4 C21B      		sub r28,r18
 117 00c6 D109      		sbc r29,__zero_reg__
 118 00c8 5881      		ld r21,Y
 119 00ca 5076      		andi r21,lo8(96)
 120 00cc 01F0      		breq .+2
 121 00ce 00C0      		rjmp .L9
 122 00d0 20E0      		ldi r18,lo8(usbTxBuf+9)
 123 00d2 30E0      		ldi r19,hi8(usbTxBuf+9)
 124 00d4 1092 0000 		sts usbTxBuf+9,__zero_reg__
 125 00d8 8981      		ldd r24,Y+1
 126 00da 8823      		tst r24
 127 00dc 01F4      		brne .L11
 128 00de 1092 0000 		sts usbTxBuf+10,__zero_reg__
 129 00e2 3093 0000 		sts (usbMsgPtr)+1,r19
 130 00e6 2093 0000 		sts usbMsgPtr,r18
 131 00ea 92E0      		ldi r25,lo8(2)
 132               	.L87:
 133 00ec 20E8      		ldi r18,lo8(-128)
 134               	.L13:
 135 00ee 6F81      		ldd r22,Y+7
 136 00f0 6623      		tst r22
 137 00f2 01F4      		brne .L41
 138 00f4 8E81      		ldd r24,Y+6
 139 00f6 8917      		cp r24,r25
 140 00f8 00F4      		brsh .L41
 141 00fa 982F      		mov r25,r24
 142 00fc 00C0      		rjmp .L41
 143               	.L11:
 144 00fe 8530      		cpi r24,lo8(5)
 145 0100 01F0      		breq .L74
 146 0102 8630      		cpi r24,lo8(6)
 147 0104 01F0      		breq .L75
 148 0106 8830      		cpi r24,lo8(8)
 149 0108 01F4      		brne .+2
 150 010a 00C0      		rjmp .L76
 151 010c 8930      		cpi r24,lo8(9)
 152 010e 01F4      		brne .+2
 153 0110 00C0      		rjmp .L77
 154 0112 8A30      		cpi r24,lo8(10)
 155 0114 01F4      		brne .+2
 156 0116 00C0      		rjmp .L78
 157 0118 8B30      		cpi r24,lo8(11)
 158 011a 01F4      		brne .+2
 159 011c 00C0      		rjmp .L39
 160 011e 00C0      		rjmp .L91
 161               	.L74:
 162 0120 7A81      		ldd r23,Y+2
 163 0122 7093 0000 		sts usbNewDeviceAddr,r23
 164 0126 00C0      		rjmp .L91
 165               	.L75:
 166 0128 8B81      		ldd r24,Y+3
 167 012a 8130      		cpi r24,lo8(1)
 168 012c 01F0      		breq .L79
 169 012e 8230      		cpi r24,lo8(2)
 170 0130 01F0      		breq .L80
 171 0132 8330      		cpi r24,lo8(3)
GAS LISTING /tmp/ccGw9bPe.s 			page 4


 172 0134 01F0      		breq .L81
 173 0136 8132      		cpi r24,lo8(33)
 174 0138 01F4      		brne .L30
 175 013a A0E0      		ldi r26,lo8(usbDescriptorConfiguration+18)
 176 013c B0E0      		ldi r27,hi8(usbDescriptorConfiguration+18)
 177 013e B093 0000 		sts (usbMsgPtr)+1,r27
 178 0142 A093 0000 		sts usbMsgPtr,r26
 179 0146 99E0      		ldi r25,lo8(9)
 180 0148 00C0      		rjmp .L88
 181               	.L79:
 182 014a 80E0      		ldi r24,lo8(usbDescriptorDevice)
 183 014c 90E0      		ldi r25,hi8(usbDescriptorDevice)
 184 014e 00C0      		rjmp .L89
 185               	.L80:
 186 0150 E0E0      		ldi r30,lo8(usbDescriptorConfiguration)
 187 0152 F0E0      		ldi r31,hi8(usbDescriptorConfiguration)
 188 0154 F093 0000 		sts (usbMsgPtr)+1,r31
 189 0158 E093 0000 		sts usbMsgPtr,r30
 190 015c 92E2      		ldi r25,lo8(34)
 191 015e 00C0      		rjmp .L88
 192               	.L81:
 193 0160 8A81      		ldd r24,Y+2
 194 0162 8823      		tst r24
 195 0164 01F4      		brne .L24
 196 0166 80E0      		ldi r24,lo8(usbDescriptorString0)
 197 0168 90E0      		ldi r25,hi8(usbDescriptorString0)
 198 016a 9093 0000 		sts (usbMsgPtr)+1,r25
 199 016e 8093 0000 		sts usbMsgPtr,r24
 200 0172 94E0      		ldi r25,lo8(4)
 201 0174 00C0      		rjmp .L88
 202               	.L24:
 203 0176 8130      		cpi r24,lo8(1)
 204 0178 01F0      		breq .L82
 205 017a 8230      		cpi r24,lo8(2)
 206 017c 01F4      		brne .L28
 207 017e 00E0      		ldi r16,lo8(usbDescriptorStringDevice)
 208 0180 10E0      		ldi r17,hi8(usbDescriptorStringDevice)
 209 0182 1093 0000 		sts (usbMsgPtr)+1,r17
 210 0186 0093 0000 		sts usbMsgPtr,r16
 211 018a 90E1      		ldi r25,lo8(16)
 212 018c 00C0      		rjmp .L88
 213               	.L82:
 214 018e 80E0      		ldi r24,lo8(usbDescriptorStringVendor)
 215 0190 90E0      		ldi r25,hi8(usbDescriptorStringVendor)
 216               	.L89:
 217 0192 9093 0000 		sts (usbMsgPtr)+1,r25
 218 0196 8093 0000 		sts usbMsgPtr,r24
 219 019a 92E1      		ldi r25,lo8(18)
 220 019c 00C0      		rjmp .L88
 221               	.L30:
 222 019e 8232      		cpi r24,lo8(34)
 223 01a0 01F4      		brne .L28
 224 01a2 40E0      		ldi r20,lo8(usbDescriptorHidReport)
 225 01a4 50E0      		ldi r21,hi8(usbDescriptorHidReport)
 226 01a6 5093 0000 		sts (usbMsgPtr)+1,r21
 227 01aa 4093 0000 		sts usbMsgPtr,r20
 228 01ae 93E2      		ldi r25,lo8(35)
GAS LISTING /tmp/ccGw9bPe.s 			page 5


 229 01b0 00C0      		rjmp .L88
 230               	.L76:
 231 01b2 20E0      		ldi r18,lo8(usbConfiguration)
 232 01b4 30E0      		ldi r19,hi8(usbConfiguration)
 233 01b6 3093 0000 		sts (usbMsgPtr)+1,r19
 234 01ba 2093 0000 		sts usbMsgPtr,r18
 235 01be 00C0      		rjmp .L92
 236               	.L77:
 237 01c0 9A81      		ldd r25,Y+2
 238 01c2 9093 0000 		sts usbConfiguration,r25
 239 01c6 00C0      		rjmp .L91
 240               	.L78:
 241 01c8 3093 0000 		sts (usbMsgPtr)+1,r19
 242 01cc 2093 0000 		sts usbMsgPtr,r18
 243               	.L92:
 244 01d0 91E0      		ldi r25,lo8(1)
 245 01d2 00C0      		rjmp .L87
 246               	.L39:
 247 01d4 B3EC      		ldi r27,lo8(-61)
 248 01d6 B093 0000 		sts usbTxBuf1,r27
 249               	.L91:
 250 01da 90E0      		ldi r25,lo8(0)
 251 01dc 00C0      		rjmp .L87
 252               	.L9:
 253 01de CE01      		movw r24,r28
 254 01e0 00D0      		rcall usbFunctionSetup
 255 01e2 982F      		mov r25,r24
 256 01e4 00C0      		rjmp .L87
 257               	.L28:
 258 01e6 90E0      		ldi r25,lo8(0)
 259               	.L88:
 260 01e8 20EC      		ldi r18,lo8(-64)
 261 01ea 00C0      		rjmp .L13
 262               	.L69:
 263 01ec 18E0      		ldi r17,lo8(8)
 264 01ee 00C0      		rjmp .L47
 265               	.L48:
 266 01f0 0BE4      		ldi r16,lo8(75)
 267 01f2 00C0      		rjmp .L50
 268               	.L70:
 269 01f4 912F      		mov r25,r17
 270 01f6 F901      		movw r30,r18
 271 01f8 A0E0      		ldi r26,lo8(usbTxBuf+1)
 272 01fa B0E0      		ldi r27,hi8(usbTxBuf+1)
 273               	.L53:
 274 01fc 9150      		subi r25,lo8(-(-1))
 275 01fe 9F3F      		cpi r25,lo8(-1)
 276 0200 01F0      		breq .L71
 277 0202 5191      		ld r21,Z+
 278 0204 5D93      		st X+,r21
 279 0206 00C0      		rjmp .L53
 280               	.L71:
 281 0208 E901      		movw r28,r18
 282 020a C10F      		add r28,r17
 283 020c D11D      		adc r29,__zero_reg__
 284 020e D093 0000 		sts (usbMsgPtr)+1,r29
 285 0212 C093 0000 		sts usbMsgPtr,r28
GAS LISTING /tmp/ccGw9bPe.s 			page 6


 286 0216 612F      		mov r22,r17
 287 0218 80E0      		ldi r24,lo8(usbTxBuf+1)
 288 021a 90E0      		ldi r25,hi8(usbTxBuf+1)
 289 021c 00D0      		rcall usbCrc16Append
 290 021e 1830      		cpi r17,lo8(8)
 291 0220 01F0      		breq .L60
 292 0222 FFEF      		ldi r31,lo8(-1)
 293 0224 F093 0000 		sts usbMsgLen,r31
 294               	.L60:
 295 0228 0093 0000 		sts usbTxBuf,r16
 296 022c 1C5F      		subi r17,lo8(-(4))
 297 022e 1093 0000 		sts usbTxLen,r17
 298 0232 00C0      		rjmp .L44
 299               	.L66:
 300               	/* epilogue: frame size=0 */
 301 0234 DF91      		pop r29
 302 0236 CF91      		pop r28
 303 0238 1F91      		pop r17
 304 023a 0F91      		pop r16
 305 023c 0895      		ret
 306               	/* epilogue end (size=5) */
 307               	/* function usbPoll size 283 (274) */
 308               		.size	usbPoll, .-usbPoll
 309               	.global	usbSetInterrupt
 310               		.type	usbSetInterrupt, @function
 311               	usbSetInterrupt:
 312               	/* prologue: frame size=0 */
 313 023e 1F93      		push r17
 314               	/* prologue end (size=1) */
 315 0240 DC01      		movw r26,r24
 316 0242 162F      		mov r17,r22
 317 0244 8091 0000 		lds r24,usbTxLen1
 318 0248 84FF      		sbrs r24,4
 319 024a 00C0      		rjmp .L94
 320 024c 2091 0000 		lds r18,usbTxBuf1
 321 0250 98E8      		ldi r25,lo8(-120)
 322 0252 2927      		eor r18,r25
 323 0254 2093 0000 		sts usbTxBuf1,r18
 324               	.L96:
 325 0258 912F      		mov r25,r17
 326 025a E0E0      		ldi r30,lo8(usbTxBuf1+1)
 327 025c F0E0      		ldi r31,hi8(usbTxBuf1+1)
 328               	.L97:
 329 025e 9150      		subi r25,lo8(-(-1))
 330 0260 9F3F      		cpi r25,lo8(-1)
 331 0262 01F0      		breq .L101
 332 0264 3D91      		ld r19,X+
 333 0266 3193      		st Z+,r19
 334 0268 00C0      		rjmp .L97
 335               	.L94:
 336 026a 4AE5      		ldi r20,lo8(90)
 337 026c 4093 0000 		sts usbTxLen1,r20
 338 0270 00C0      		rjmp .L96
 339               	.L101:
 340 0272 612F      		mov r22,r17
 341 0274 80E0      		ldi r24,lo8(usbTxBuf1+1)
 342 0276 90E0      		ldi r25,hi8(usbTxBuf1+1)
GAS LISTING /tmp/ccGw9bPe.s 			page 7


 343 0278 00D0      		rcall usbCrc16Append
 344 027a 1C5F      		subi r17,lo8(-(4))
 345 027c 1093 0000 		sts usbTxLen1,r17
 346               	/* epilogue: frame size=0 */
 347 0280 1F91      		pop r17
 348 0282 0895      		ret
 349               	/* epilogue end (size=2) */
 350               	/* function usbSetInterrupt size 35 (32) */
 351               		.size	usbSetInterrupt, .-usbSetInterrupt
 352               	.global	usbMsgLen
 353               		.data
 354               		.type	usbMsgLen, @object
 355               		.size	usbMsgLen, 1
 356               	usbMsgLen:
 357 0000 FF        		.byte	-1
 358               	.global	usbTxLen
 359               		.type	usbTxLen, @object
 360               		.size	usbTxLen, 1
 361               	usbTxLen:
 362 0001 5A        		.byte	90
 363               	.global	usbTxLen1
 364               		.type	usbTxLen1, @object
 365               		.size	usbTxLen1, 1
 366               	usbTxLen1:
 367 0002 5A        		.byte	90
 368               	.global	usbDescriptorString0
 369               		.section	.progmem.data,"a",@progbits
 370               		.type	usbDescriptorString0, @object
 371               		.size	usbDescriptorString0, 4
 372               	usbDescriptorString0:
 373 0000 04        		.byte	4
 374 0001 03        		.byte	3
 375 0002 09        		.byte	9
 376 0003 04        		.byte	4
 377               	.global	usbDescriptorStringVendor
 378               		.type	usbDescriptorStringVendor, @object
 379               		.size	usbDescriptorStringVendor, 18
 380               	usbDescriptorStringVendor:
 381 0004 1203      		.word	786
 382 0006 6F00      		.word	111
 383 0008 6200      		.word	98
 384 000a 6400      		.word	100
 385 000c 6500      		.word	101
 386 000e 7600      		.word	118
 387 0010 2E00      		.word	46
 388 0012 6100      		.word	97
 389 0014 7400      		.word	116
 390               	.global	usbDescriptorStringDevice
 391               		.type	usbDescriptorStringDevice, @object
 392               		.size	usbDescriptorStringDevice, 16
 393               	usbDescriptorStringDevice:
 394 0016 1003      		.word	784
 395 0018 4800      		.word	72
 396 001a 4900      		.word	73
 397 001c 4400      		.word	68
 398 001e 4B00      		.word	75
 399 0020 6500      		.word	101
GAS LISTING /tmp/ccGw9bPe.s 			page 8


 400 0022 7900      		.word	121
 401 0024 7300      		.word	115
 402               	.global	usbDescriptorDevice
 403               		.type	usbDescriptorDevice, @object
 404               		.size	usbDescriptorDevice, 18
 405               	usbDescriptorDevice:
 406 0026 12        		.byte	18
 407 0027 01        		.byte	1
 408 0028 10        		.byte	16
 409 0029 01        		.byte	1
 410 002a 00        		.byte	0
 411 002b 00        		.byte	0
 412 002c 00        		.byte	0
 413 002d 08        		.byte	8
 414 002e 42        		.byte	66
 415 002f 42        		.byte	66
 416 0030 31        		.byte	49
 417 0031 E1        		.byte	-31
 418 0032 00        		.byte	0
 419 0033 01        		.byte	1
 420 0034 01        		.byte	1
 421 0035 02        		.byte	2
 422 0036 00        		.byte	0
 423 0037 01        		.byte	1
 424               	.global	usbDescriptorConfiguration
 425               		.type	usbDescriptorConfiguration, @object
 426               		.size	usbDescriptorConfiguration, 34
 427               	usbDescriptorConfiguration:
 428 0038 09        		.byte	9
 429 0039 02        		.byte	2
 430 003a 22        		.byte	34
 431 003b 00        		.byte	0
 432 003c 01        		.byte	1
 433 003d 01        		.byte	1
 434 003e 00        		.byte	0
 435 003f 80        		.byte	-128
 436 0040 32        		.byte	50
 437 0041 09        		.byte	9
 438 0042 04        		.byte	4
 439 0043 00        		.byte	0
 440 0044 00        		.byte	0
 441 0045 01        		.byte	1
 442 0046 03        		.byte	3
 443 0047 00        		.byte	0
 444 0048 00        		.byte	0
 445 0049 00        		.byte	0
 446 004a 09        		.byte	9
 447 004b 21        		.byte	33
 448 004c 01        		.byte	1
 449 004d 01        		.byte	1
 450 004e 00        		.byte	0
 451 004f 01        		.byte	1
 452 0050 22        		.byte	34
 453 0051 23        		.byte	35
 454 0052 00        		.byte	0
 455 0053 07        		.byte	7
 456 0054 05        		.byte	5
GAS LISTING /tmp/ccGw9bPe.s 			page 9


 457 0055 81        		.byte	-127
 458 0056 03        		.byte	3
 459 0057 08        		.byte	8
 460 0058 00        		.byte	0
 461 0059 0A        		.byte	10
 462               		.lcomm usbMsgFlags,1
 463               		.comm usbMsgPtr,2,1
 464               		.comm usbConfiguration,1,1
 465               		.comm usbTxBuf1,11,1
 466               		.comm usbRxBuf,22,1
 467               		.comm usbInputBufOffset,1,1
 468               		.comm usbDeviceAddr,1,1
 469               		.comm usbNewDeviceAddr,1,1
 470               		.comm usbRxLen,1,1
 471               		.comm usbCurrentTok,1,1
 472               		.comm usbRxToken,1,1
 473               		.comm usbTxBuf,11,1
 474               	/* File "usbdrv/usbdrv.c": code  328 = 0x0148 ( 315), prologues   5, epilogues   8 */
