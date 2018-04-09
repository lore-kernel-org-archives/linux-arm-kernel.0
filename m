From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 9 Apr 2018 10:53:56 +0200
Subject: SUN6I a31 OPP table clock issue
In-Reply-To: <c309c971-7559-e1d9-dc9f-2f7a7ad6f3cb@orpaltech.com>
References: <c309c971-7559-e1d9-dc9f-2f7a7ad6f3cb@orpaltech.com>
Message-ID: <20180409085356.goemvdy3ecyqoghp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 07, 2018 at 10:53:10PM +0300, Sergey Suloev wrote:
> I was able to catch oops coming from OPP table on BananaPi M2.
> 
> https://pastebin.com/ZRaXTtEx
> 
> Let me know if need more detail.

Of course we do.

Which kernel version was this for? With which configuration? What
makes you say it's related to the OPP table, is it a regression or
something you just noticed?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/cd58ac63/attachment.sig>
