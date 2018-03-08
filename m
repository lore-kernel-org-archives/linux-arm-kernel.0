From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Mar 2018 16:11:59 +0100
Subject: [PATCH 0/3] ARM: dts: tegra: apalis/colibri updates
In-Reply-To: <20180210013638.28164-1-marcel@ziswiler.com>
References: <20180210013638.28164-1-marcel@ziswiler.com>
Message-ID: <20180308151159.GC13814@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 02:36:35AM +0100, Marcel Ziswiler wrote:
> 
> This series fixes the I2C bus frequencies, uses the correct compatible
> for the RTC and removes an unneeded reg property for Tegra based
> Toradex Apalis and Colibri modules.
> 
> 
> Marcel Ziswiler (3):
>   apalis_t30/tk1, colibri_t20/t30: fix i2c bus frequencies
>   ARM: dts: tegra: apalis/colibri: use correct compatible for rtc
>   ARM: dts: tegra: apalis/colibri: remove unneeded reg property
> 
>  arch/arm/boot/dts/tegra124-apalis-eval.dts    |  7 +++----
>  arch/arm/boot/dts/tegra124-apalis.dtsi        |  2 +-
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi    | 16 +++++++++++-----
>  arch/arm/boot/dts/tegra30-apalis-eval.dts     |  4 ++--
>  arch/arm/boot/dts/tegra30-apalis.dtsi         |  3 +--
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  4 ++--
>  arch/arm/boot/dts/tegra30-colibri.dtsi        |  3 +--
>  7 files changed, 21 insertions(+), 18 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/2c7bd8da/attachment.sig>
