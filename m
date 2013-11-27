From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Nov 2013 10:27:46 +0100
Subject: [PATCH 5/4] ARM: at91: don't use <mach/timex.h>
In-Reply-To: <5294BB7C.6030307@atmel.com>
References: <1385474690-6483-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5294BB7C.6030307@atmel.com>
Message-ID: <20131127092746.GP28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 04:17:16PM +0100, Nicolas Ferre wrote:
> On 26/11/2013 15:04, Uwe Kleine-K?nig :
> >The platform specific <mach/timex.h> will be removed in a later patch.
> >So move its only still used symbol to its only user. Also add a few
> >explicit includes of <mach/hardware.h> that are implicitly available
> >through <mach/timex.h>.
> >
> >Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> >---
> >Hello,
> >
> >assuming it's OK for you, please only give an ack and don't take that
> >patch as I intend to keep it in a series deprecating <mach/timex.h>.
> 
> Okay, I let you take this one.
> 
> Thanks a lot. bye,

Build testing showed that I have to add several more #include
<mach/hardware.h>, I will send a v2.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
