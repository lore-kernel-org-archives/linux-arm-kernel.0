From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Nov 2017 09:23:50 +0100
Subject: [PATCH 1/2] arm64: dts: allwinner: H5: remove redundant MMC0
 card detect pin
In-Reply-To: <20171125120200.23294-2-andre.przywara@arm.com>
References: <20171125120200.23294-1-andre.przywara@arm.com>
 <20171125120200.23294-2-andre.przywara@arm.com>
Message-ID: <20171127082350.7yzg44mdmei3w47i@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 12:01:59PM +0000, Andre Przywara wrote:
> PF6 is mostly used as the CD pin for the microSD slot on H5 based
> boards. So far we were referencing this pin twice: once using the
> mmc0_cd_pin phandle, and then again directly as a GPIO via the pinctrl
> phandle.
> This will cause problems if the pinctrl driver enables strict mode, as
> the second request will fail now, leading to a driver init failure.
> Remove the redundant pin reference via the mmc0_cd_pin phandle.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Chris Obbard <obbardc@gmail.com>

Applied for 4.16, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171127/bdda0a9e/attachment.sig>
