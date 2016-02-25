From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 10:49:44 -0800
Subject: [PATCH v3 04/10] drivers: pinctrl: add driver for Allwinner A64
 SoC
In-Reply-To: <1456165255-31013-5-git-send-email-andre.przywara@arm.com>
References: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
 <1456165255-31013-5-git-send-email-andre.przywara@arm.com>
Message-ID: <20160225184944.GI4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 22, 2016 at 06:20:49PM +0000, Andre Przywara wrote:
> Based on the Allwinner A64 user manual and on the previous sunxi
> pinctrl drivers this introduces the pin multiplex assignments for
> the ARMv8 Allwinner A64 SoC.
> Port A is apparently used for the fixed function DRAM controller, so
> the ports start at B here (the manual mentions "n from 1 to 7", so
> not starting at 0).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Linus, could you merge this patch for 4.6?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/f0ca1553/attachment-0001.sig>
