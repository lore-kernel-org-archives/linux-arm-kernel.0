From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Feb 2014 20:09:17 +0100
Subject: [PATCH] phy: restrict Samsung S5P/Exynos drivers to the
 respective architectures
In-Reply-To: <53077707.9060409@samsung.com>
References: <1392991526-20895-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <53077707.9060409@samsung.com>
Message-ID: <20140221190917.GN6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 04:55:51PM +0100, Sylwester Nawrocki wrote:
> Hi,
> 
> On 21/02/14 15:05, Uwe Kleine-K?nig wrote:
> > Enabling these drivers on platforms not created by Samsung is useless
> > unless you're doing compile tests. So don't offer the users to enable
> > them without COMPILE_TEST for configs with S5P/Exynos disabled.
> 
> Thanks for the patch, I've already sent something similar to Kishon, but
> I've messed up the mailing list address. A bit improved v2 I just posted
> can be found here:
> 
> https://patchwork.kernel.org/patch/3698271/
> https://patchwork.kernel.org/patch/3698251/
fine for me. If you need to repost feel free to add my Ack for these.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
