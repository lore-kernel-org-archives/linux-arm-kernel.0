From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Feb 2016 20:18:45 +0100
Subject: [PATCH v6] i2c: mt8173: add 4GB mode support in i2c driver.
In-Reply-To: <1454347143-31461-1-git-send-email-liguo.zhang@mediatek.com>
References: <1454347143-31461-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <20160212191845.GN1520@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 01:19:03AM +0800, Liguo Zhang wrote:
> If 4GB mode is enable, we should add 4gb mode support in i2c driver.
> Set 4GB mode register to support 4GB mode.
> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>

The subject should have "mt65xx" since this is the driver name. I also
added DMA to the commit message to make clear what this mode is about.

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/3605881a/attachment-0001.sig>
