From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 1 Jun 2015 17:43:41 +0100
Subject: [PATCH 1/2 v2] ARM64: juno: add GPIO keys
In-Reply-To: <CACRpkdaem5kTvgiswkp7SB+nJntDpV1Ycai1hzm2kWcpA+rKSA@mail.gmail.com>
References: <1432629650-19559-1-git-send-email-linus.walleij@linaro.org>
 <20150526093734.GB2175@e106497-lin.cambridge.arm.com>
 <CACRpkdbm9LxaWQa=SQAhOKYVncPoFiKv_M6cN1oUEqctiR5=pQ@mail.gmail.com>
 <20150527144052.GF2175@e106497-lin.cambridge.arm.com>
 <CACRpkdaem5kTvgiswkp7SB+nJntDpV1Ycai1hzm2kWcpA+rKSA@mail.gmail.com>
Message-ID: <20150601164341.GE2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 10:02:10AM +0100, Linus Walleij wrote:
> On Wed, May 27, 2015 at 4:40 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> 
> > Also useful if you can capture the text printed by BL1 when booting (depending
> > on which version you have there might not be much).
> 
> Oh that is just the v1.1 tag.
> 
> INFO:    BL1: 0x403a000 - 0x403d000 [size = 12288]
> NOTICE:  Booting Trusted Firmware
> NOTICE:  BL1: v1.1(debug):68fc81743e86
> NOTICE:  BL1: Built : 14:03:21, May 26 2015
> INFO:    BL1: RAM 0x403a000 - 0x403d000
> INFO:    Using FIP
> INFO:    Loading file 'bl2.bin' at address 0x4017000
> INFO:    File 'bl2.bin' loaded: 0x4017000 - 0x401c008
> NOTICE:  BL1: Booting BL2
> INFO:    BL1: BL2 address = 0x4017000
> INFO:    BL1: BL2 spsr = 0x3c5
> NOTICE:  BL2: v1.1(debug):68fc81743e86
> NOTICE:  BL2: Built : 14:03:22, May 26 2015
> INFO:    BL2: Loading BL3-0
> INFO:    Using FIP
> INFO:    Loading file 'bl30.bin' at address 0x4023000
> INFO:    Skip reserving memory: 0x4023000 - 0x402e144
> INFO:    File 'bl30.bin' loaded: 0x4023000 - 0x402e144
> INFO:    BL2: BL3-0 transferred to SCP
> INFO:    BL2: Loading BL3-1
> INFO:    Using FIP
> INFO:    Loading file 'bl31.bin' at address 0x4023000
> INFO:    File 'bl31.bin' loaded: 0x4023000 - 0x402b010
> INFO:    BL2: Loading BL3-2
> INFO:    Using FIP
> WARNING: Failed to access image 'bl32.bin' (-1)
> WARNING: Failed to load BL3-2 (-1)
> INFO:    BL2: Loading BL3-3
> INFO:    Using FIP
> INFO:    Loading file 'bl33.bin' at address 0xe0000000
> INFO:    File 'bl33.bin' loaded: 0xe0000000 - 0xe0035068
> NOTICE:  BL1: Booting BL3-1
> INFO:    BL1: BL3-1 address = 0x4023000
> INFO:    BL1: BL3-1 spsr = 0x3cd
> INFO:    BL1: BL3-1 params address = 0x401c8a0
> INFO:    BL1: BL3-1 plat params address = 0xf1e2d3c4b5a6978
> NOTICE:  BL3-1: v1.1(debug):68fc81743e86
> NOTICE:  BL3-1: Built : 14:03:24, May 26 2015
> INFO:    BL3-1: Initializing runtime services
> INFO:    BL3-1: Preparing for EL3 exit to normal world
> INFO:    BL3-1: Next image address = 0xe0000000
> INFO:    BL3-1: Next image spsr = 0x3c9
> 
> Do you want me to test on some older version of TF?

No, it's fine.

I have tested the patches on my Juno R0, so you can add my

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

> 
> > UEFI firmware (version a4c2dfb284a55e73f34c48f5944a438006384f04 built at 17:44:48 on Jan 13 2015)
> 
> I'm using U-Boot, of course ;)

Should I, too? :)

Best regards,
Liviu

> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
