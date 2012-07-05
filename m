From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 15:13:29 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF59F5C.8050002@linaro.org>
References: <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF58B68.5000703@linaro.org>
 <20120705124549.GD4111@opensource.wolfsonmicro.com>
 <201207051357.07195.arnd@arndb.de> <4FF59F5C.8050002@linaro.org>
Message-ID: <20120705141329.GN4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 03:06:20PM +0100, Lee Jones wrote:
> On 05/07/12 14:57, Arnd Bergmann wrote:

> >The non-DT path for this is a huge mess, I'd rather focus on making
> >it obsolete than trying to fix it. Other than that, I agree that
> >we should be registering the ab8500 from the prcmu from both the
> >DT and the non-DT case.

> Ah, is that what you were saying Mark?

> If so, I apologise. I thought you meant register both from platform
> code. I'm happy to register the AB8500 from the DB8500 for _both_ DT
> and !DT.

Yes, that's what I was trying to say - sorry that I wasn't clear!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/33b512ca/attachment-0001.sig>
