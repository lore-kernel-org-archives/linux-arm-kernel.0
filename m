From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Jun 2014 10:51:49 +0100
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAD=FV=Ua+P0CBAfNj4SWWMWRKcEFdmh=akwy1-ZWoGOt2P9=cQ@mail.gmail.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=Ua+P0CBAfNj4SWWMWRKcEFdmh=akwy1-ZWoGOt2P9=cQ@mail.gmail.com>
Message-ID: <20140621095149.GY5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 02:18:08PM -0700, Doug Anderson wrote:

> Is one of you two planning to apply (parts 1 and 2)?  I know that
> Kukjin needs to handle the part 3 (the .dts files)...

> Ideally it seems like it could go to 3.16 since it is a bugfix...

Don't nag, it just means yet more mail to look at which makes things
worse not better.  Given all the problems the DT code for this driver
has I need to review carefully, and the fact that this has got to v5
before I had a chance to look at it sets off alarm bells too.

There's a couple of months to get bug fixes in yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/32b5cc67/attachment.sig>
