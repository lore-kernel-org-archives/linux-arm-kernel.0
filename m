From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 28 Nov 2016 18:42:41 +0200
Subject: [GIT PULL] ARM: keystone: add TI SCI protocol support for v4.10
In-Reply-To: <e6b04eeb-ebfb-2da0-834b-1da440a35783@ti.com>
References: <e6b04eeb-ebfb-2da0-834b-1da440a35783@ti.com>
Message-ID: <d685444b-4275-e6e6-aae6-214a41776a28@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping on this, is anybody going to pull this one?

-Tero

On 27/10/16 12:30, Tero Kristo wrote:
> Hi Arnd, Olof, Kevin,
>
> This pull introduces the TI SCI protocol support for keystone family of
> devices, targeted for v4.10 merge window. We discussed with Santosh
> (keystone maintainer) that it would probably be better that I'll be
> sending the pull requests for this directly, avoiding one extra step of
> merges.
>
> -Tero
>
>
> The following changes since commit
> 1001354ca34179f3db924eb66672442a173147dc:
>
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
>
> are available in the git repository at:
>
>   https://github.com/t-kristo/linux-pm.git for-4.10-ti-sci-base
>
> for you to fetch changes up to 912cffb4ed8612dc99ee0251cc0c9785855162cd:
>
>   firmware: ti_sci: Add support for reboot core service (2016-10-27
> 12:09:12 +0300)
>
> ----------------------------------------------------------------
> Nishanth Menon (5):
>       Documentation: Add support for TI System Control Interface
> (TI-SCI) protocol
>       firmware: Add basic support for TI System Control Interface
> (TI-SCI) protocol
>       firmware: ti_sci: Add support for Device control
>       firmware: ti_sci: Add support for Clock control
>       firmware: ti_sci: Add support for reboot core service
>
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    |   81 +
>  MAINTAINERS                                        |   10 +
>  drivers/firmware/Kconfig                           |   15 +
>  drivers/firmware/Makefile                          |    1 +
>  drivers/firmware/ti_sci.c                          | 1991
> ++++++++++++++++++++
>  drivers/firmware/ti_sci.h                          |  492 +++++
>  include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
>  7 files changed, 2839 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>  create mode 100644 drivers/firmware/ti_sci.c
>  create mode 100644 drivers/firmware/ti_sci.h
>  create mode 100644 include/linux/soc/ti/ti_sci_protocol.h
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
