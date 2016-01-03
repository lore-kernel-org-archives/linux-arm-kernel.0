From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 3 Jan 2016 19:38:43 +0100
Subject: [PATCH v3] i2c: mediatek: fix i2c multi transfer issue in high
 speed mode
In-Reply-To: <1450164146-28995-1-git-send-email-liguo.zhang@mediatek.com>
References: <1450164146-28995-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <20160103183843.GF1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 03:22:26PM +0800, Liguo Zhang wrote:
> For mt8173 platform with auto restart support, when doing i2c multi
> transfer in high speed, we should ignore the first restart irq after
> the master code, otherwise the first transfer will be discarded.
> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Reviewed-by: Eddie Huang <eddie.huang@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160103/f580a572/attachment.sig>
