From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 28 Apr 2018 15:12:27 +0200
Subject: [PATCH] i2c: mediatek: use of_device_get_match_data()
In-Reply-To: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
Message-ID: <20180428131227.u7cuvdhuo3dahsdt@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 10:32:52AM +0800, Ryder Lee wrote:
> The usage of of_device_get_match_data() reduce the code size a bit.
> 
> Also, the only way to call mtk_i2c_probe() is to match an entry in
> mtk_i2c_of_match[], so of_id cannot be NULL.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to for-next, thanks!

Does somebody from Mediatek maybe want to maintain this driver?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180428/168eb78c/attachment.sig>
