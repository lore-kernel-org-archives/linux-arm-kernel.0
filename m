From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 15:04:12 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <201207051357.07195.arnd@arndb.de>
References: <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF58B68.5000703@linaro.org>
 <20120705124549.GD4111@opensource.wolfsonmicro.com>
 <201207051357.07195.arnd@arndb.de>
Message-ID: <20120705140412.GM4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 01:57:06PM +0000, Arnd Bergmann wrote:

> The non-DT path for this is a huge mess, I'd rather focus on making
> it obsolete than trying to fix it. Other than that, I agree that
> we should be registering the ab8500 from the prcmu from both the
> DT and the non-DT case.

If that's the decision then we should probably have a comment in the
code saying that this is what's going on to warn off anyone who's
inclined to cut'n'paste.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/8f8a8547/attachment.sig>
