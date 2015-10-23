From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 23 Oct 2015 21:59:11 +0200
Subject: [PATCH] i2c: mediatek: add i2c resume support
In-Reply-To: <1444123376-24448-1-git-send-email-eddie.huang@mediatek.com>
References: <1444123376-24448-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20151023195911.GB1520@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 05:22:56PM +0800, Eddie Huang wrote:
> From: Liguo Zhang <liguo.zhang@mediatek.com>
> 
> mt65xx i2c controller initial setting will be cleared after system suspend,
> so we should init mt65xx i2c controller again when system resume.
> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/e3cb883e/attachment-0001.sig>
