From: xvzhaobin@gmail.com (zhaobin xv)
Date: Wed, 7 Aug 2013 18:57:15 +0800
Subject: angel_SWI_ARM
Message-ID: <CANEcUBW2OsQqN_Cm_9ThJmcmNB5oQfNvqNi_MU+DsCNAPJtaFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
when I read linux/arch/arm/boot/compressed/head.S
I can't understand :
 mrs    r2, cpsr        @ get current mode
        tst    r2, #3            @ not user?
        bne    not_angel
        mov    r0, #0x17        @ angel_SWIreason_EnterSVC
        swi    0x123456        @ angel_SWI_ARM
I want to know :
a) what is angel_SWI_ARM
b) what is angel debuger
c)Do the code " swi    0x123456 " make interrupt what make program
jump to addr 0x0000 0008
,but addr 0x0000 0008 doesn't initialize.
