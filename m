From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Jun 2016 18:26:18 +0200
Subject: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
In-Reply-To: <20160618162138.GC3017@tetsubishi>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
 <20160618162138.GC3017@tetsubishi>
Message-ID: <20160618162618.GE3017@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 18, 2016 at 06:21:39PM +0200, Wolfram Sang wrote:
> On Fri, Jun 10, 2016 at 11:38:20PM +0530, Sricharan R wrote:
> > index gets incremented during check to determine if the
> > messages can be transferred with dma. But not reset after
> > that, resulting in wrong start value in subsequent loop,
> > causing failure. Fix it.
> > 
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> 
> Applied to for-next, thanks!

Reconsidered and applied to for-current.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/e06088fc/attachment-0001.sig>
