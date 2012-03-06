From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 12:16:28 +0000
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <CAN1soZxdT=N1BtK5Jf4+Qu3GGCHPuKK1BqgfEV-D7QorjnsLpg@mail.gmail.com>
References: <1330989122-6323-1-git-send-email-paul.gortmaker@windriver.com>
 <4F55CEDB.90909@compulab.co.il>
 <CAN1soZxdT=N1BtK5Jf4+Qu3GGCHPuKK1BqgfEV-D7QorjnsLpg@mail.gmail.com>
Message-ID: <20120306121627.GM19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 05:12:18PM +0800, Haojian Zhuang wrote:

> Could you pick up this patch since it's depend on latest change on regulator?

There's no direct dependency, there's been no need to use that struct
member for years - should be safe to just apply via the PXA tree.  If
you do want it to go via regulator please resend, I didn't keep a copy
of the patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/7b99136b/attachment.sig>
