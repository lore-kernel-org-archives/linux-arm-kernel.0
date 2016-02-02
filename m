From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 10:44:07 +0100
Subject: [PATCH 03/11] drivers: rtc: allow compilation of sun6i RTC for
 all sunxi SoCs
In-Reply-To: <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
Message-ID: <20160202094407.GL4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 05:39:22PM +0000, Andre Przywara wrote:
> At the moment the "sun6i" RTC drivers depends on having two specific
> SoC families selected.
> The Allwinner A64 SoC has the same RTC, so extend the Kconfig option
> to allow inclusion of the driver for all Allwinner SoCs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/52e72ac3/attachment-0001.sig>
