From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Feb 2014 09:31:16 -0600
Subject: [PATCH] phy: restrict Samsung S5P/Exynos drivers to the
 respective architectures
In-Reply-To: <1392991526-20895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1392991526-20895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140221153116.GC31902@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 03:05:26PM +0100, Uwe Kleine-K?nig wrote:
> Enabling these drivers on platforms not created by Samsung is useless
> unless you're doing compile tests. So don't offer the users to enable
> them without COMPILE_TEST for configs with S5P/Exynos disabled.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

fine by me

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140221/50cbf1bb/attachment.sig>
