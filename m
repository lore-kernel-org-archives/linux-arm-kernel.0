From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 23 Aug 2013 21:02:47 +0200
Subject: [PATCH] misc: (at24) move header to linux/platform_data/
In-Reply-To: <1377283100-10390-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1377283100-10390-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Message-ID: <20130823190247.GA3821@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 02:38:20PM -0400, Vivien Didelot wrote:
> This patch moves the at24.h header from include/linux/i2c to
> include/linux/platform_data and updates existing support accordingly.

This message explains what the patch does but not why the change is
wanted. I'd be surprised if we really want *all* platform_data in one
single directory? Is this patch part of a bigger series? That being said
i2c is not the best place for this include, in deed...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/b3400d2a/attachment.sig>
