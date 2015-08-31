From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 31 Aug 2015 12:39:44 +0000
Subject: [PATCH 0/3] Add support for the Armada-370-based Seagate NAS
In-Reply-To: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
References: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150831123944.GK3684@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 29, 2015 at 06:46:42PM +0200, Simon Guinot wrote:
> Hi,
> 
> This patch series adds support for the Seagate machines based on the
> Armada-370 Marvell SoC. This includes the Personal Cloud 1 and 2-Bay
> and the Seagate NAS 2 and 4-Bay.
> 
> Thanks,
> 
> Simon
> 
> Simon Guinot (2):
>   ARM: mvebu: add DT support for Seagate Personal Cloud
>   ARM: mvebu: enable options for Seagate NAS in mvebu_v7_defconfig
> 
> Vincent Donnefort (1):
>   ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay
> 
>  arch/arm/boot/dts/Makefile                |   4 +
>  arch/arm/boot/dts/armada-370-n090103.dts  |  28 ++++
>  arch/arm/boot/dts/armada-370-n090201.dts  |  28 ++++
>  arch/arm/boot/dts/armada-370-n090203.dts  |  42 ++++++
>  arch/arm/boot/dts/armada-370-n090401.dts  | 124 ++++++++++++++++
>  arch/arm/boot/dts/armada-370-n090x01.dtsi | 232 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-370-n090x03.dtsi | 174 ++++++++++++++++++++++
>  arch/arm/configs/mvebu_v7_defconfig       |   9 +-
>  8 files changed, 640 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armada-370-n090103.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-n090201.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-n090203.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-n090401.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-n090x01.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-370-n090x03.dtsi

Could you please name these something more informative?  e.g.
armada-370-seagate-personal-cloud-{1,2}.dts, etc?

thx,

Jason.
