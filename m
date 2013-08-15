From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Aug 2013 09:43:37 -0700
Subject: Broken device trees for exynos in linux-next
Message-ID: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Thu, Aug 15, 2013 at 12:34 AM,  <build@lixom.net> wrote:

>         exynos5440_defconfig:
> ERROR: Input tree has errors, aborting (use -f to force output)
>
>         exynos_defconfig:
> ERROR: Input tree has errors, aborting (use -f to force output)

Full error is:

  DTC     arch/arm/boot/dts/exynos5420-smdk5420.dtb
ERROR (phandle_references): Reference to non-existent node or label "pdma1"
ERROR (phandle_references): Reference to non-existent node or label "pdma1"
ERROR (phandle_references): Reference to non-existent node or label "pdma0"
ERROR (phandle_references): Reference to non-existent node or label "pdma0"

Looks like you have broken device trees in linux next. Also, what is
exynos5440_defconfig? Don't add contents (which includes defconfigs)
to linux-next branches that won't make it all the way upstream.


Thanks,

-Olof
