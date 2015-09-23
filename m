From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 23 Sep 2015 14:30:33 -0500
Subject: [RESEND PATCHv3] arm64: dts: Add base stratix 10 dtsi
In-Reply-To: <1442353625-4552-1-git-send-email-dinguyen@opensource.altera.com>
References: <1442353625-4552-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <CADhT+wf91qp=bGPk5kZj=_QP6qKeBmx1UJda_4+u3av7uO+m7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 4:47 PM,  <dinguyen@opensource.altera.com> wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> Add the base DTS for Altera's SoCFPGA Stratix 10 platform.
>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v3: change #address-cells and #size-cells to <2>
>     change the GIC address to 0xfffc1000
>     update the GIC virtual CPU reg length to 0x2000
> v2: use interrupt-affinity for pmu node
> ---
>  arch/arm64/Kconfig.platforms                       |   5 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/altera/Makefile                |   5 +
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 357 +++++++++++++++++++++
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  39 +++
>  arch/arm64/configs/defconfig                       |   1 +
>  6 files changed, 408 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/altera/Makefile
>  create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>  create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>

Gentle ping?

Thanks,
Dinh
