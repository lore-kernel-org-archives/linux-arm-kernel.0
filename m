From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Jan 2018 00:55:58 +0100
Subject: [PATCH 3/3] i2c: mediatek: Enable i2c module clock before i2c
 registers access.
In-Reply-To: <1513666263-6443-4-git-send-email-jun.gao@mediatek.com>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-4-git-send-email-jun.gao@mediatek.com>
Message-ID: <20180103235558.z24e6c6vq6ctlpd4@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 02:51:03PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Make sure i2c module clock has been enabled before i2c registers
> access.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/55e8bcab/attachment.sig>
