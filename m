From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 11 Jan 2018 08:35:58 -0600
Subject: [PATCH] arm64: dts: socfpga: add missing interrupt-parent
In-Reply-To: <20180110210431.2330267-1-arnd@arndb.de>
References: <20180110210431.2330267-1-arnd@arndb.de>
Message-ID: <e3a44268-88f2-3dbd-a992-f9484a82d826@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/10/2018 03:04 PM, Arnd Bergmann wrote:
> The PMU node has no working interrupt, as shown by this dtc warning:
> 
> arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu
> 
> This adds an interrupt-parent property so we can correct parse
> that interrupt number.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If this looks ok, I'd apply it directly to the fixes branch
> for 4.15, as the warning is one that was introduced in this
> release.

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Yes, please feel free to apply it. And thanks alot!

Dinh
