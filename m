From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Jan 2018 00:55:54 +0100
Subject: [PATCH 2/3] i2c: mediatek: Add i2c compatible for MediaTek MT2712
In-Reply-To: <1513666263-6443-3-git-send-email-jun.gao@mediatek.com>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <20180103235554.euwpwsaayx4qnsao@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 02:51:02PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add i2c compatible for MT2712. Compare to MT8173 i2c controller,
> internal divider of i2c source clock need to be configured for
> MT2712 i2c speed calculation.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/9aae6901/attachment-0001.sig>
