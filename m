From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Oct 2016 10:58:59 +0100
Subject: [PATCH 0/3] ARM: dts: oxnas: Update support for OX820 and use
 dt-bindings
In-Reply-To: <20161021151037.20112-1-narmstrong@baylibre.com>
References: <20161021151037.20112-1-narmstrong@baylibre.com>
Message-ID: <fce063fd-6aaa-8d30-1588-e656e93bdebc@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 05:10 PM, Neil Armstrong wrote:
> This patchset updates the ARM DTS for the Oxnas platform by :
> - Add support for the Oxford Semicondutor OX820 and the PogoPlug V3
> - Update the OX810SE to use the dt-bindings includes files introduced in [1] and [2]
> - Fix the MAINTAINERS entry and add the PogoPlug V3 file maintainance
> 
> This patchset depends on dt-bindings include headers posted at [1] and [2],
> that were accepted/merged in the subsystem trees.
> 
> How could I manage this dependency for 4.10 ?
> 
> [1] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00008.html
> [2] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00007.html
> 
> Neil Armstrong (3):
>   ARM: dts: Add support for OX820 and Pogoplug V3
>   ARM: dts: OX810: Update with dt-bindings includes
>   MAINTAINERS: oxnas: Add new files definitions
> 
>  Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
>  MAINTAINERS                                        |   3 +-
>  arch/arm/boot/dts/Makefile                         |   3 +-
>  .../boot/dts/cloudengines-pogoplug-series-3.dts    |  94 +++++++
>  arch/arm/boot/dts/ox810se.dtsi                     |  10 +-
>  arch/arm/boot/dts/ox820.dtsi                       | 298 +++++++++++++++++++++
>  6 files changed, 407 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
>  create mode 100644 arch/arm/boot/dts/ox820.dtsi
> 

Hi,

I'm ready to send a pull request for arm-soc-dt, but I need to understand how this dependency
should be worked out.

Should this be sent as a late pull request ?

Thanks,
Neil
