From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 27 Feb 2016 17:53:31 +0800
Subject: [PATCH V5 0/3] add gpio/pinctrl/spi DTS for hi6220 and hikey
In-Reply-To: <1455883107-8411-1-git-send-email-guodong.xu@linaro.org>
References: <1455883107-8411-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <56D1721B.1080506@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guodong,

On 19/02/2016 19:58, Guodong Xu wrote:
> As of V4, this patchset has been ack'ed by Rob Herring.
> 
> V5, added pmx0 pmx1 pmx2 nodes description into hi6220.dtsi.
> 
> Zhong Kaihua (3):
>   arm64: dts: Add Hi6220 gpio configuration nodes
>   arm64: dts: add Hi6220 pinctrl configuration nodes
>   arm64: dts: add Hi6220 spi configuration nodes
> 
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   |   3 +
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 351 +++++++++++
>  arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi    | 607 +++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 705 +++++++++++++++++++++++
>  include/dt-bindings/pinctrl/hisi.h               |  59 ++
>  5 files changed, 1725 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
>  create mode 100644 include/dt-bindings/pinctrl/hisi.h
> 

Applied all the patches into the hisilicon soc tree.
Thanks!

Best Regards,
Wei
