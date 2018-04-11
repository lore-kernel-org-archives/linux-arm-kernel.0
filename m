From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Apr 2018 10:19:25 +0200
Subject: [PATCH] ARM: dts: sunxi: Change sun7i-a20-olimex-som204-evb to
 not use cd-inverted
In-Reply-To: <20180410145119.27362-1-tuomas@tuxera.com>
References: <20180410145119.27362-1-tuomas@tuxera.com>
Message-ID: <20180411081925.hjhobvessykaiqoq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 05:51:19PM +0300, Tuomas Tynkkynen wrote:
> Commit 45e01f401a2a16 ("ARM: dts: sunxi: Switch MMC nodes away from
> cd-inverted property") changed most of the sunxi boards away from using
> the cd-inverted property in MMC nodes. However, the
> sun7i-a20-olimex-som204-evb board which got merged concurrently with
> that commit is now using cd-inverted. Switch it away from using
> cd-inverted to be consistent with rest of the sunxi boards.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180411/dec31094/attachment.sig>
