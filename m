From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Jan 2018 00:55:50 +0100
Subject: [PATCH 1/3] dt-bindings: i2c: Add MediaTek MT2712 i2c binding
In-Reply-To: <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <20180103235550.vh6adlqtkb4zmpsu@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 02:51:01PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT2712 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT2712 has timing adjust registers which can adjust
> the internal divider of i2c source clock, SCL duty cycle, SCL
> compare point, start(repeated start) and stop time, SDA change
> time.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/e33cf956/attachment.sig>
