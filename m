From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 3 Apr 2014 17:34:26 -0500
Subject: [PATCH] ARM: socfpga: dts: convert to preprocessor includes
In-Reply-To: <1396472237-6341-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396472237-6341-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396564466.28799.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-02 at 22:57 +0200, Steffen Trumtrar wrote:
> Convert all socfpga DT files to the dtc preprocessor include syntax.
> This allows to include header files in the devicetrees like other
> SoC-types already do.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi                  | 2 +-
>  arch/arm/boot/dts/socfpga_arria5.dtsi           | 2 +-
>  arch/arm/boot/dts/socfpga_arria5_socdk.dts      | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi         | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts    | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 2 +-
>  arch/arm/boot/dts/socfpga_vt.dts                | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 
I have applied this to rocketboards linux-socfpga-next/next-dt.

Thanks,
Dinh
