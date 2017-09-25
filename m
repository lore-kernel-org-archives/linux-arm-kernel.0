From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 Sep 2017 10:19:44 +0200
Subject: [PATCH 1/2] arm: dts: Add support for National Instruments
 Project Sulfur SDRs
In-Reply-To: <20170911232223.91894-1-mdf@kernel.org>
References: <20170911232223.91894-1-mdf@kernel.org>
Message-ID: <314acb1f-1f0f-7893-70a8-9379c01112ac@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz

sorry for delay.

On 12.9.2017 01:22, Moritz Fischer wrote:
> Add support for the National Instruments Project Sulfur SDR
> motherboards Rev 2,3 and 4.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  arch/arm/boot/dts/Makefile                |   3 +
>  arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts |  84 +++++++++++++++++++
>  arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts | 118 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts |  26 ++++++
>  arch/arm/boot/dts/zynq-ni-sulfur.dtsi     | 133 ++++++++++++++++++++++++++++++
>  5 files changed, 364 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts
>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts
>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts
>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur.dtsi

Is this publicly available board?

I am not quite sure we should apply these dts files. There are a lot of
boards with zynq and there must be any strong argument for applying this
to the tree. For arm32 with even flat tree structure.

Arnd: Do you have any policy about it?

Thanks,
Michal
