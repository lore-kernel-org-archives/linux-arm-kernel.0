From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 03:34:23 +0200
Subject: [PATCH 2/2] i2c: exynos5: Add Kconfig dependencies
In-Reply-To: <1410859998-29285-3-git-send-email-ch.naveen@samsung.com>
References: <1410859998-29285-1-git-send-email-ch.naveen@samsung.com>
 <1410859998-29285-3-git-send-email-ch.naveen@samsung.com>
Message-ID: <20141003013423.GJ1323@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 03:03:18PM +0530, Naveen Krishna Chatradhi wrote:
> The i2c-exynos5.c driver can be reused for the HSI2C controller
> on Exynos7 SoCs from Samsung.
> 
> This patch adds the Kconfig dependency to choose i2c-exynos5.c
> for CONFIG_ARCH_EXYNOS7.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

Folded this one into the previous one.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/fc9fe2b0/attachment.sig>
