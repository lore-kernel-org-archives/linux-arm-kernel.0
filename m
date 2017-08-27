From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 27 Aug 2017 15:31:47 +0200
Subject: [PATCH v4 2/3] dt-bindings: i2c: Add MediaTek MT7622 i2c binding
In-Reply-To: <1503286614-17670-3-git-send-email-jun.gao@mediatek.com>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
 <1503286614-17670-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <20170827133147.gv3mjvz3buodta26@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 11:36:53AM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT7622 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT7622 limits message numbers to 255, and does not
> support 4GB DMA mode.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170827/71d60c52/attachment-0001.sig>
