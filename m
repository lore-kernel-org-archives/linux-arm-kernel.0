From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Thu, 14 Jun 2018 09:28:52 -0700
Subject: [Intel-wired-lan] [PATCH v3 16/27] docs: Fix more broken
 references
In-Reply-To: <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
Message-ID: <fe2520d95598838cb4fcfca93b635de002cbf68a.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-14 at 13:09 -0300, Mauro Carvalho Chehab wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
>         ./scripts/documentation-file-ref-check --fix
> 
> Manually checked that produced results are valid.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the Intel networking Kconfig changes.

> ---
>  .../devicetree/bindings/clock/st/st,clkgen.txt |  8 ++++----
>  .../devicetree/bindings/clock/ti/gate.txt      |  2 +-
>  .../devicetree/bindings/clock/ti/interface.txt |  2 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt      |  2 +-
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt |  2 +-
>  .../bindings/gpu/arm,mali-midgard.txt          |  2 +-
>  .../bindings/gpu/arm,mali-utgard.txt           |  2 +-
>  .../devicetree/bindings/mfd/mt6397.txt         |  2 +-
>  .../devicetree/bindings/mfd/sun6i-prcm.txt     |  2 +-
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt |  2 +-
>  .../devicetree/bindings/net/dsa/ksz.txt        |  2 +-
>  .../devicetree/bindings/net/dsa/mt7530.txt     |  2 +-
>  .../devicetree/bindings/power/fsl,imx-gpc.txt  |  2 +-
>  .../bindings/power/wakeup-source.txt           |  2 +-
>  .../devicetree/bindings/usb/rockchip,dwc3.txt  |  2 +-
>  Documentation/hwmon/ina2xx                     |  2 +-
>  Documentation/maintainer/pull-requests.rst     |  2 +-
>  Documentation/translations/ko_KR/howto.rst     |  2 +-
>  MAINTAINERS                                    | 18 +++++++++-------
> --
>  drivers/net/ethernet/intel/Kconfig             |  8 ++++----
>  drivers/soundwire/stream.c                     |  8 ++++----
>  fs/Kconfig.binfmt                              |  2 +-
>  fs/binfmt_misc.c                               |  2 +-
>  23 files changed, 40 insertions(+), 40 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180614/64507779/attachment-0001.sig>
