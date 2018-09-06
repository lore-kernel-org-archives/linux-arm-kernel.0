From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 6 Sep 2018 20:33:47 +0200
Subject: [PATCH v3 2/2] i2c: mediatek: Use DMA safe buffers for i2c
 transactions
In-Reply-To: <1536239729-10008-3-git-send-email-jun.gao@mediatek.com>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
 <1536239729-10008-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <20180906183347.GE8607@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 09:15:29PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> DMA mode will always be used in i2c transactions, try to allocate
> a DMA safe buffer if the buf of struct i2c_msg used is not DMA safe.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/dc3e7fae/attachment.sig>
