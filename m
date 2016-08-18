From: catalin.crenguta@gmail.com (Catalin Crenguta)
Date: Thu, 18 Aug 2016 09:01:17 +0300
Subject: [arm] Vyvrid pcm052: Unable to boot v4.8-rc2
Message-ID: <CABH3fy-JuBvZym=SWkjqftkbFS6njerFLj8gVWeh7Hho0ZumBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am trying to bringup a Phycore Vybrid (pcm052) by Phytec using linux
v4.8-rc2(dts:  vf610-cosmic.dts). I am using this SoM on a Rapid
Development Kit from Phytec.

The kernel code execution hangs very quick, like this:
"Starting kernel ...

undefined instruction
pc : [<80008010>]          lr : [<8ff6c17d>]
reloc pc : [<2f4a5010>]    lr : [<3f40917d>]
sp : 8fd66c90  ip : 00000000     fp : 00000000
r10: 00000000  r9 : 8fd66ed8     r8 : 8fd70b34
r7 : 00000000  r6 : 80008000     r5 : 8ffb9530  r4 : 00000000
r3 : 00003d9d  r2 : 8fd5e000     r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
Resetting CPU ...

resetting ... "

Any suggestions? thanks.
