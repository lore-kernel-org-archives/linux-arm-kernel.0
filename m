From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 27 Aug 2017 15:31:52 +0200
Subject: [PATCH v4 3/3] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
In-Reply-To: <1503286614-17670-4-git-send-email-jun.gao@mediatek.com>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
 <1503286614-17670-4-git-send-email-jun.gao@mediatek.com>
Message-ID: <20170827133152.igoqe4ftzslza3um@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 11:36:54AM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add i2c compatible for MT7622. Compare to MT8173 i2c controller,
> MT7622 limits message numbers to 255, and does not support 4GB
> DMA mode.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170827/ce369c6b/attachment.sig>
