From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 27 Nov 2018 15:21:03 +0100
Subject: [PATCH v3 4/4] ARM: dts: Add stmpe-adc driver to relevant
 devicetrees
In-Reply-To: <20181123142411.8921-4-dev@pschenker.ch>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-4-dev@pschenker.ch>
Message-ID: <20181127142103.GC10560@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 03:24:11PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - None
> 
> Changes in v2:
>  - Put common ADC settings in mfd
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 23 +++++++++++++++--------
>  arch/arm/boot/dts/tegra30-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-colibri.dtsi | 22 ++++++++++++++--------
>  4 files changed, 57 insertions(+), 32 deletions(-)

You might want to split this up into two patches, one for i.MX and the
other for Tegra so that the respective maintainers can apply them
separately.

Also, where are patches 1-3?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/c0d2cd93/attachment.sig>
