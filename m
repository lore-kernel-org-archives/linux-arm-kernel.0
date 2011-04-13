From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Apr 2011 08:20:43 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <alpine.LFD.2.00.1104121850160.28032@xanadu.home>
References: <1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
	<20110412095446.GB18850@pengutronix.de>
	<20110412202734.GB7806@n2100.arm.linux.org.uk>
	<20110412203730.GE18850@pengutronix.de>
	<20110412205344.GE7806@n2100.arm.linux.org.uk>
	<20110412212050.GF18850@pengutronix.de>
	<alpine.LFD.2.00.1104121850160.28032@xanadu.home>
Message-ID: <20110413062043.GG18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Apr 12, 2011 at 06:54:30PM -0400, Nicolas Pitre wrote:
> On Tue, 12 Apr 2011, Uwe Kleine-K?nig wrote:
> 
> > Apart from defining PLAT_PHYS_OFFSET these symbols are used in the
> > machine files to define .boot_params. This is better than repeating the
> > bare numbers, isn't it?
> 
> Sure.
> 
> > The current arch/arm/plat-mxc/include/mach/memory.h looks ok for me. I 
> > assume you concur?
> 
> Maybe you should replace CONFIG_RUNTIME_PHYS_OFFSET with 
> CONFIG_ARM_PATCH_PHYS_VIRT in that file.
This is already commited to my private repo.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
