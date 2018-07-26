From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 09:31:38 +0200
Subject: [PATCH] arm64: dts: allwinner: activate spi flash on pine64 LTS
 board
In-Reply-To: <20180726072924.bnvljmd2sf6bf5ae@flea>
References: <Akash_Gajjar@mentor.com>
 <1532587906-5415-1-git-send-email-Akash_Gajjar@mentor.com>
 <20180726072924.bnvljmd2sf6bf5ae@flea>
Message-ID: <20180726073138.fexu4nxaamqmrbzb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 09:29:24AM +0200, Maxime Ripard wrote:
> 1;5202;0c
> On Thu, Jul 26, 2018 at 12:21:46PM +0530, Akash Gajjar wrote:
> > This board has SPI flash. add spi flash support in device tree.
> > Tested on pine64 LTS.
> > 
> > Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> 
> Queued for 4.20, thanks!

No, sorry, I ended up droping that patch.

You mention that the Pine64 LTS has an SPI flash, yet you change the
sopine baseboard dts. Why is that?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/c3a0783f/attachment-0001.sig>
