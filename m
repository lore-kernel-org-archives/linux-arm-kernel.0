From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 13 Jul 2011 13:40:39 +0000
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Dong Aisheng-B29396
> Sent: Wednesday, July 13, 2011 8:19 PM
> To: Wolfram Sang
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; u.kleine-koenig at pengutronix.de;
> lrg at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver

> >
> > Proper regulator support for mxs is not in mainline yet. Is that
> planned?
> > How do you do it?
> 
> Yes, it's not in mainline yet.
> Fixed regulator may be a method.
> However currently I just removed VDDIO and VDDA checking in sgtl5000
> driver.
> Additionally, it seems sgtl5000 driver still needs another fix to get it
> running.
> I copy the patch as below for your info(Just for test).
> I'm going to do that in my following work.
> 

For regulator issue, One method is that just add two regulator (VDDA&VDDIO)
needed by sgtl5000 in platform code to make sgtl5000 work first.
If that I could add it in my the following patches.

Or we do not add it (just leave sgtl5000 unwork), instead, we directly
implement the full regulator support for MX28 power management?

What's your suggestion?

Regards
Dong Aisheng
