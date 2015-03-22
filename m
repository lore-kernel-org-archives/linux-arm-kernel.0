From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 Mar 2015 10:13:17 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB0561AA9DE7988D33159117138A0E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320081910.GF10068@pengutronix.de>
 <HK2PR06MB0561AA9DE7988D33159117138A0E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20150322091317.GF5664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

On Fri, Mar 20, 2015 at 08:18:10PM +0000, Chris Brandt wrote:
> > > Of course to actually boot an XIP kernel, you have to make a custom command in u-boot (using bootm or go is not going to work).
> > It should. I remember that you need to pass something unintuitive to
> > mkimage (to not say buggy). See
> > http://lists.denx.de/pipermail/u-boot/2007-March/020171.html for my
> > try to fix that back when I still cared about U-Boot.
> 
> I originally started down that path...but it was so screwed up and
> really only worked for the power PC architecture. It was more work to
> hack it than just making a very simple function that loaded the
> R0,R1,R2 registers and jumped to the start of the kernel.
Back then it worked for me on ARM, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
