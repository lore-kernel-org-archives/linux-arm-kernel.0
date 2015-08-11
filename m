From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 11 Aug 2015 16:55:21 +0200
Subject: [PATCH v2 2/2] i2c: mediatek: Fixup i2c ack error interrupt
 handling
In-Reply-To: <1438845731-17805-3-git-send-email-eddie.huang@mediatek.com>
References: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
 <1438845731-17805-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150811145521.GB1525@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 03:22:11PM +0800, Eddie Huang wrote:
> When occur i2c ack error, i2c controller generate two interrupts,
> first is the ack error interrupt, then the complete interrupt.
> i2c interrupt handler should keep the two interrupt value, and only
> call complete() for the complete interrupt.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150811/05b4bbc5/attachment.sig>
