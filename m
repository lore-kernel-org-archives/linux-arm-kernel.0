From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 12:55:13 +0000
Subject: [PATCH] clocksource: Fix build in non-OF case
In-Reply-To: <201303281239.46639.arnd@arndb.de>
References: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201303281239.46639.arnd@arndb.de>
Message-ID: <20130328125513.GY18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 12:39:46PM +0000, Arnd Bergmann wrote:

> Axel Lin reported the same problem and I fixed the below code earlier
> today by using the correct __attribute__((unused)) and dropping the
> section magic for the non-OF case. My patch now looks contains the

That still looks like it'll reference the function?

> change below. I also proposed a fix for the clocksource driver
> at http://lkml.org/lkml/2013/3/26/103.

This is a different driver that I'm trying to look at here, the s3c24xx
one which is still not merged.  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/c4ff6eb6/attachment.sig>
