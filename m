From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Apr 2017 16:54:10 +0200
Subject: [PATCH 0/4] ARM: sunxi: device tree pinctrl clean up and H3 OTG
In-Reply-To: <20170419050919.6762-1-wens@csie.org>
References: <20170419050919.6762-1-wens@csie.org>
Message-ID: <20170419145410.k2nkyfrz6ss7o2tt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 01:09:15PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This series has 2 parts. The parts are largely unrelated, though the
> second part should be applied after the first part, so we don't
> accidentally mux pins that we shouldn't. Hence I'm sending them
> together.
> 
> The first 2 patches clean up the sunxi device tree files, removing
> pinmux settings for common GPIO pins. These include the enable pins
> for the common regulators, and the mmc0 card detect pin from the
> reference designs.
> 
> The second part, the latter 2 patches, enable USB OTG on the Orangepi
> PC, PC Plus, Plus 2E, and the Bananapi M2+. The first 3 boards are
> bunched together, due to how the PC Plus and Plus 2E device trees include
> the device tree of the Opi PC.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170419/97e6c778/attachment.sig>
