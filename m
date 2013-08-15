From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Aug 2013 20:20:26 +0200
Subject: [PATCH v2] ARM: ARMv7-M: implement restart routine common to all
 v7-M machines
In-Reply-To: <520CF8B1.20609@arm.com>
References: <1376581536-14742-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <520CF8B1.20609@arm.com>
Message-ID: <20130815182026.GI30496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Aug 15, 2013 at 04:50:09PM +0100, Jonathan Austin wrote:
> On 15/08/13 16:45, Uwe Kleine-K?nig wrote:
> >The newly introduced function is to be used as .restart callback for
> >ARMv7-M machines. The used register is architecturally defined, so it
> >should work for all M-class machines.
> >
> >Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >---
> >
> >Changes since v1, sent with Message-Id:
> >1376494625-25496-1-git-send-email-u.kleine-koenig at pengutronix.de:
> >
> >  - add a more verbose change log
> >  - rename arch/arm/kernel/common-v7m.c to arch/arm/kernel/v7m.c
> >
> 
> Thanks Uwe, this looks good now - assuming Russell's happy with
> arch/arm/kernel/v7m.c :)
I'd like to get this patch, the efm32-clk patch (Message-Id:
1376510693-12491-1-git-send-email-u.kleine-koenig at pengutronix.de) and
the patch introducing the efm32 platform (Message-Id:
1376552964-16296-1-git-send-email-u.kleine-koenig at pengutronix.de) merged
for 3.12. So assuming you are OK with this change I'd like to let the
arm-soc people pull the three patches from a single branch. For that I'd
like to have you ack.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
