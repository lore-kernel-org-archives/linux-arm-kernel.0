From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Jul 2017 21:34:47 +0200
Subject: [PATCH] ARM64: allwinner: sun50i-a64: Correct emac register size
In-Reply-To: <20170710184440.28946-1-clabbe.montjoie@gmail.com>
References: <20170710184440.28946-1-clabbe.montjoie@gmail.com>
Message-ID: <20170711193447.pk7jbqnzl2u4xbxp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 08:44:40PM +0200, Corentin Labbe wrote:
> The datasheet said that emac register size is 0x10000 not 0x100
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170711/b9944185/attachment.sig>
