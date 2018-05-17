From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 17 May 2018 16:32:03 +0200
Subject: [PATCH 0/7] i2c: clean up include/linux/i2c-*
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Message-ID: <20180517143202.vzwmqkemlqxj2xgu@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 10:00:06PM +0200, Wolfram Sang wrote:
> Move all plain platform_data includes to the platform_data-dir
> (except for i2c-pnx which can be moved into the driver itself).
> 
> My preference is to take these patches via the i2c tree. I can provide an
> immutable branch if needed. But we can also discuss those going in via
> arch-trees if dependencies are against us.

All applied to for-next!

The immutable branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data-immutable

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/41d00c49/attachment.sig>
