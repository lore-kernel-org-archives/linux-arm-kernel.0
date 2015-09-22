From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 22 Sep 2015 10:58:51 +0200
Subject: [PATCH v2 0/3] Add support for the Armada-370-based Seagate NAS
In-Reply-To: <1442008373-19184-1-git-send-email-simon.guinot@sequanux.org>
References: <1442008373-19184-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150922085851.GT7306@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 11:52:50PM +0200, Simon Guinot wrote:
> Hi,
> 
> This patch series adds support for the Seagate machines based on the
> Armada-370 Marvell SoC. This includes the Personal Cloud 1 and 2-Bay
> and the Seagate NAS 2 and 4-Bay.
> 
> Changes for v2:
> - Rename DTS files using the products names.
> - Update model and compatible properties as well.
> - Add some informations allowing to identify the devices in the commit
>   message and in the DTS files headers.
> - Remove duplicated rtc alias in armada-370-seagate-nas-xbay.dtsi.

Hi Jason, Andrew, Gregory, and Sebastian,

Please, consider merging this patch series.

Thanks,

Simon

> Simon Guinot (2):
>   ARM: mvebu: add DT support for Seagate Personal Cloud
>   ARM: mvebu: enable options for Seagate NAS in mvebu_v7_defconfig
> 
> Vincent Donnefort (1):
>   ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay
> 
>  arch/arm/boot/dts/Makefile                         |   4 +
>  arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |  36 ++++
>  arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 133 ++++++++++++
>  arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 231 +++++++++++++++++++++
>  .../armada-370-seagate-personnal-cloud-2bay.dts    |  51 +++++
>  .../dts/armada-370-seagate-personnal-cloud.dts     |  37 ++++
>  .../dts/armada-370-seagate-personnal-cloud.dtsi    | 174 ++++++++++++++++
>  arch/arm/configs/mvebu_v7_defconfig                |   9 +-
>  8 files changed, 674 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-370-seagate-personnal-cloud-2bay.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-seagate-personnal-cloud.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-seagate-personnal-cloud.dtsi
> 
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/87140c0e/attachment.sig>
