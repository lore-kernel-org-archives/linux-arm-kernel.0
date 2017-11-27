From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Nov 2017 09:22:52 +0100
Subject: [PATCH 2/2] pinctrl: sunxi: Disable strict mode for H5 driver
In-Reply-To: <20171125120200.23294-3-andre.przywara@arm.com>
References: <20171125120200.23294-1-andre.przywara@arm.com>
 <20171125120200.23294-3-andre.przywara@arm.com>
Message-ID: <20171127082252.wpf6vhe6f2zxshpn@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 12:02:00PM +0000, Andre Przywara wrote:
> All of the H5 boards in the kernel reference the MMC0 CD pin twice in
> their DT, so strict mode will make the MMC driver fail to load.
> To keep existing DTs working, disable strict mode in the H5 driver.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Chris Obbard <obbardc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Sorry for missing that one...

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171127/9ab5f5ee/attachment.sig>
