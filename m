From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 6 Sep 2018 20:31:44 +0200
Subject: [PATCH v3 1/2] i2c: mediatek: Register i2c adapter driver earlier
In-Reply-To: <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
 <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <20180906183144.GD8607@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 09:15:28PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> In order not to block the initializations of some i2c devices.
> Register i2c adapter driver at appropriate time.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

The reasons this patch was rejected in v2 still hold.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/8e20f8ac/attachment.sig>
