From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 11:10:57 +0100
Subject: [PATCH V3 1/7] ARM: dts: Change i2s compatible string on
 exynos5250
In-Reply-To: <1375866616-5541-2-git-send-email-padma.v@samsung.com>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
 <1375866616-5541-2-git-send-email-padma.v@samsung.com>
Message-ID: <20130807101057.GY6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 02:40:10PM +0530, Padmavathi Venna wrote:
> This patch removes quirks from i2s node and change the i2s
> compatible names.

This needs to go along with the driver change otherwise we break
bisection.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/7ded5473/attachment-0001.sig>
