From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Aug 2013 12:50:54 -0700
Subject: [PATCH] ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
In-Reply-To: <20130815084259.GG30496@pengutronix.de>
References: <1376552964-16296-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130815084259.GG30496@pengutronix.de>
Message-ID: <20130828195054.GJ8607@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the delay in responding to this. See below.

On Thu, Aug 15, 2013 at 10:42:59AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> I forgot to mention that this patch depends on the following patches:
> 
>  - ARM: ARMv7-M: implement restart routine common to all v7-M machines
>    sent with Message-Id: 1376494305-24270-1-git-send-email-u.kleine-koenig at pengutronix.de; and

Seems like you addressed Russell's comments here, so hopefully he's ok with us
picking it up directly as a prereq.

>  - clk: new driver for efm32 SoC
>    sent with Message-Id: 1376510693-12491-1-git-send-email-u.kleine-koenig at pengutronix.de

This can be applied directly by Mike, since the code doesn't depend on each
other (just won't be fully functional until both lands).

> So in the unlikely case you are already happy with this patch, it needs
> some coordination to go in.

I'll have a few comments, should hopefully be quick to respin.


-Olof
