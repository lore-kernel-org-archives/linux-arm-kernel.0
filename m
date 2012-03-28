From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 11:51:22 +0100
Subject: [PATCH] ARM: Samsung: Make PM_GENERIC_DOMAINS config depend on
 CONFIG_PM
In-Reply-To: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
References: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20120328105122.GF3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 03:46:43PM +0530, Thomas Abraham wrote:
> For s3c64xx and exynos platforms, make the selection of PM_GENERIC_DOMAINS
> depend on the CONFIG_PM.

What's the underlying issue here?  This seems like something the PM core
should be dealing with gracefully...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/1a3f6236/attachment.sig>
