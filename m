From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 17 Jul 2014 12:02:36 +0200
Subject: [PATCH 1/2 v2] i2c: exynos5: remove an unnecessary read of
 FIFO_STATUS register
In-Reply-To: <1403759698-15624-1-git-send-email-ch.naveen@samsung.com>
References: <1403759698-15624-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140717100235.GB2740@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 10:44:57AM +0530, Naveen Krishna Chatradhi wrote:
> This patch removes an extra read of FIFO_STATUS register in the interrrupt
> service routine. Which is read again before the actual use.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/469f1137/attachment.sig>
