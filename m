From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 11:16:43 +0100
Subject: [PATCH] exynos: Support big endian mode in secondary_startup
In-Reply-To: <073c01cfa7c3$39ec6a10$adc53e30$@samsung.com>
References: <1405958507-8606-1-git-send-email-broonie@kernel.org>
 <073c01cfa7c3$39ec6a10$adc53e30$@samsung.com>
Message-ID: <20140725101643.GN17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 01:45:14PM +0900, Kukjin Kim wrote:

> Basically, I have no objection on this, BTW is there any requirement to support
> big endian on exynos stuff? Just wondering...

We've been using it for testing within Linaro.  I don't know of any real
world users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/d9825cfb/attachment.sig>
