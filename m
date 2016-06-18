From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Jun 2016 18:21:39 +0200
Subject: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
In-Reply-To: <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160618162138.GC3017@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 11:38:20PM +0530, Sricharan R wrote:
> index gets incremented during check to determine if the
> messages can be transferred with dma. But not reset after
> that, resulting in wrong start value in subsequent loop,
> causing failure. Fix it.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/e0c6e786/attachment.sig>
