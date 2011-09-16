From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 16 Sep 2011 09:50:33 +0200
Subject: [PATCH v12 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <4E7218A0.2020309@eurekelettronica.it>
References: <1315450031-6371-1-git-send-email-b32955@freescale.com>
	<20081.44941.12535.496764@ipc1.ka-ro>
	<4E71CDB2.4000205@freescale.com>
	<4E7218A0.2020309@eurekelettronica.it>
Message-ID: <20082.65481.262062.390598@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

gianluca writes:
> Sorry for intrusion in this discussion, but:
> 
> Huang Shijie wrote:
> >> channels are being used concurrently. The GPMI driver will bail out
> >> with the timeout error while the MMC driver obviously has no timeout
> >> check for this situation.
> >>
> >> I can mostly rule out HW problems, because the same board works
> >> perfectly well with WindowsCE (tested with a copy operation between
> >> flash and SD card).
> >>
> >>
> >> Lothar Wa?mann
> 
> @Lothar: Probably WinCE with a copy operation between flash and SD is 
> not reliable as synchronous as opposed dd command in the previous mail.
> 
I know that a copy operation on WinCE is not an adequate test. That's
why I wrote 'I can _mostly_ rule out...'.

I'll try to do more agressive tests with WinCE to verify whether the
hardware is actually not to blame.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
