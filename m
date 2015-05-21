From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 May 2015 08:43:35 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <1432161344-1930-1-git-send-email-stefan@agner.ch>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
Message-ID: <20150521064335.GX24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 12:35:44AM +0200, Stefan Agner wrote:
> Use the new config symbol ARM_SINGLE_ARMV7M which groups config
> symbols used by modern ARMv7-M platforms. This allows supporting
> multiple ARMv7-M platforms in one kernel image. However, a common
> kernel image requires the combined platforms to share the same
> main memory layout to be bootable.
> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Since this is essentially only a shift of config symbols, it
> should not change runtime behavior, at least when selecting
> only one platform.
> 
> Uwe, this is essentially the same I had in my patchset, just
> converting the other platforms too. I was bold and added your
> Ack anyway...
That's fine.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
