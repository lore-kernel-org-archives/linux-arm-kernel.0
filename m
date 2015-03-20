From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 20 Mar 2015 20:18:10 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <20150320081910.GF10068@pengutronix.de>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320081910.GF10068@pengutronix.de>
Message-ID: <HK2PR06MB0561AA9DE7988D33159117138A0E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Of course to actually boot an XIP kernel, you have to make a custom command in u-boot (using bootm or go is not going to work).
> It should. I remember that you need to pass something unintuitive to mkimage (to not say buggy). See http://lists.denx.de/pipermail/u-boot/2007-March/020171.html for my try to fix that back when I still cared about U-Boot.

I originally started down that path...but it was so screwed up and really only worked for the power PC architecture. It was more work to hack it than just making a very simple function that loaded the R0,R1,R2 registers and jumped to the start of the kernel.

Chris
