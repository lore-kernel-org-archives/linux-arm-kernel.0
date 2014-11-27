From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 13:03:01 +0000
Subject: [PATCH v4 1/7] mfd: max77686/802: Remove support for board files
In-Reply-To: <1417087253-12306-2-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141127130301.GX7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 12:20:47PM +0100, Krzysztof Kozlowski wrote:
> The driver is used only on Exynos based boards with DTS support.
> After removal of board file support from max77686 and max77802 regulator
> drivers, the MFD driver can be converted to DTS-only version. This
> simplifies a little the code:

Why is this a dependency for new features in the regulator core?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/3d80f30f/attachment.sig>
