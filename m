From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 12 Mar 2014 20:20:37 +0100
Subject: [PATCH 2/2 v4] i2c: exynos5: configure fifo_depth based on HSI2C
 module variant
In-Reply-To: <1391748195-12490-1-git-send-email-ch.naveen@samsung.com>
References: <1385100851-32254-1-git-send-email-ch.naveen@samsung.com>
 <1391748195-12490-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140312192037.GC28891@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:13:15AM +0530, Naveen Krishna Chatradhi wrote:
> fifo_depth of the HSI2C is not constant
> Exynos5420 and Exynos5250 supports fifo_depth of 64bytes
> Exynos5260 supports fifo_depth of 16bytes.
> 
> This patch configures the fifo_depth based on HSI2C modules version.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ich.naveen@samsung.com>
> [For finding out the difference and initial contribution]
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

I know Tomasz said differently, but I prefer the patches squashed (and
the commit message extended).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/2b6d2864/attachment.sig>
