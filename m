From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 11 Aug 2015 16:55:12 +0200
Subject: [PATCH v2 1/2] i2c: mediatek: Reset DMA engine in hardware init
 function
In-Reply-To: <1438845731-17805-2-git-send-email-eddie.huang@mediatek.com>
References: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
 <1438845731-17805-2-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150811145512.GA1525@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 03:22:10PM +0800, Eddie Huang wrote:
> Reset DMA in hardware init function to avoid unknown hardware state
> before do any I2C operation.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150811/34345e43/attachment.sig>
