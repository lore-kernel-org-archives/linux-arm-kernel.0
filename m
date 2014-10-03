From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 03:34:05 +0200
Subject: [PATCH 1/2] i2c: exynos: add support for HSI2C module on Exynos7
In-Reply-To: <1410859998-29285-2-git-send-email-ch.naveen@samsung.com>
References: <1410859998-29285-1-git-send-email-ch.naveen@samsung.com>
 <1410859998-29285-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <20141003013404.GI1323@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 03:03:17PM +0530, Naveen Krishna Chatradhi wrote:
> The HSI2C module on Exynos7 differs in the transfer status
> bits. Transfer status bits were moved to INT_ENABLE and
> INT_STATUS registers
> 
> This patch adds support for the HSI2C module on Exynos7.
> 1. Implementes a "hw" field in the variant struct to distinguish
>    the hardware.
> 2. Updates the dt-new compatible in dt-binding documenation
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/2f95d274/attachment.sig>
