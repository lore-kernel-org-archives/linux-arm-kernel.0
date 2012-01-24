From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Jan 2012 20:25:45 +0100
Subject: LPC32xx status (Re: [PATCH] Correct bad gpio naming)
In-Reply-To: <4F1EDD15.7010704@antcom.de>
References: <4F1C4E25.6070801@antcom.de> <20120124155921.GH2609@pengutronix.de>
 <4F1EDD15.7010704@antcom.de>
Message-ID: <20120124192545.GB8502@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Since you are modifying LPC32xx :) Which kernel version do you run?
> > I was trying to get a board up with 3.0 (not booting) and 3.3-rc1
> > (build breakage). I even thought about removing that mach, since
> > vital parts seem to be missing (Net, NAND) or broken. So, I am
> > interested if there are still users.
> 
> I'm actively maintaining an LPC32xx machine line (WORK Microwave GmbH
> devices) at http://git.antcom.de/ - feel free to merge from there.

Cool, best answer I could get \o/

> Expect the first one of the drivers to be submitted soon, I will do
> them one by one.

I think the first step should be adding a generic defconfig and make sure this
builds and boots (I think I have a phy3250 somewhere, so I could test). After
that new drivers would make sense. IIRC clock.c was pretty broken, we needed
hacks to get USB working with a 2.6.35. I also see that your tree modifies it.

Kevin: Are you with us?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/6d8e020a/attachment.sig>
