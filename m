From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Jun 2016 18:20:15 +0200
Subject: [PATCH V4 1/3] i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is
 enabled
In-Reply-To: <1465582101-19391-2-git-send-email-sricharan@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160618162014.GA3017@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 11:38:19PM +0530, Sricharan R wrote:
> With CONFIG_DEBUG_SG is enabled and when dma mode is used, below dump is seen,
> 

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/899c917d/attachment.sig>
