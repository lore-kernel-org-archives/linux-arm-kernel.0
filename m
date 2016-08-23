From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Aug 2016 21:37:44 +0200
Subject: [PATCH v4 1/7] arm64: sunxi: Kconfig: add essential pinctrl driver
In-Reply-To: <20160808172149.30861-2-andre.przywara@arm.com>
References: <20160808172149.30861-1-andre.przywara@arm.com>
 <20160808172149.30861-2-andre.przywara@arm.com>
Message-ID: <20160823193744.GP2598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 06:21:43PM +0100, Andre Przywara wrote:
> The pinctrl driver is essential for the Allwinner SoCs to work.
> Add the driver's config symbol to the Kconfig entry to always compile
> it in. We can't use the arm approach to make the _driver's_ Kconfig
> symbol def_bool, because we lack the MACH_* symbols in arm64.
> That line was in the original pinctrl driver patch, but got removed
> to avoid the dependency on the Kconfig patch [1].
> Also add the general PINCTRL symbol, which isn't selected automatically
> for the same reason.
> 
> Reported-by: Jeroen Dekien <dekien@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/414086.html

Applied, thanks

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/509e835d/attachment.sig>
