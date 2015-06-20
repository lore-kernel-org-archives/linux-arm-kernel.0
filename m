From: carlo@caione.org (Carlo Caione)
Date: Sat, 20 Jun 2015 09:36:38 +0200
Subject: [PATCH 0/4] meson: Add and enable DTS for Odroid-C1 and Tronfy MXQ
In-Reply-To: <1433753545-7980-1-git-send-email-carlo@caione.org>
References: <1433753545-7980-1-git-send-email-carlo@caione.org>
Message-ID: <CAOQ7t2b-3YCruU=QcBvN23gRy9zQVmcaYFr2eHoF-uzD96ChFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 8, 2015 at 10:52 AM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> This patchset enables Meson8b and add the DTS files for Hardkernel Odroid-C1
> and Tronfy MXQ.
>
> Note that the DTS files depend on the header file that is already submitted
> with the clock driver patches and already present in the clk tree in the
> clk-meson8b branch.
>
> Carlo Caione (4):
>   of: documentation: Add vedor prefix for Hardkernel and Tronfy
>   of: documentation: add bindings documentation for Meson8b
>   ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards
>   ARM: meson: Enable Meson8b SoCs
>
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   2 +
>  arch/arm/boot/dts/Makefile                         |   3 +
>  arch/arm/boot/dts/meson8b-mxq.dts                  |  65 +++++++++
>  arch/arm/boot/dts/meson8b-odroidc1.dts             |  65 +++++++++
>  arch/arm/boot/dts/meson8b.dtsi                     | 151 +++++++++++++++++++++
>  arch/arm/mach-meson/Kconfig                        |   5 +
>  arch/arm/mach-meson/meson.c                        |   1 +
>  8 files changed, 298 insertions(+)
>  create mode 100644 arch/arm/boot/dts/meson8b-mxq.dts
>  create mode 100644 arch/arm/boot/dts/meson8b-odroidc1.dts
>  create mode 100644 arch/arm/boot/dts/meson8b.dtsi

Any feedback on this?

-- 
Carlo Caione
