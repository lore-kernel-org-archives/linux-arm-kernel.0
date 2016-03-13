From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:32:32 -0800
Subject: [GIT PULL]Hisilicon Hi6220 SoC and Hikey board DT updates for 4.6
In-Reply-To: <56E1498F.2030107@hisilicon.com>
References: <56E1498F.2030107@hisilicon.com>
Message-ID: <20160313013232.GD5883@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 06:16:47PM +0800, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> Please help to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei

Hi Wei,

Sending the main pull request for a platform after -rc7 is much too late.
We will sometimes take incremental smaller updates late in the cycle, but we
ask for all main material to be present earlier. (We also sometimes make an
exception if we make a mistake and miss a pull request).

So, please resend this after -rc1 and we can queue it for 4.7.

Also, see below:

>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   | 196 ++++++-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 586 +++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi    | 607 +++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 705 +++++++++++++++++++++++
>  include/dt-bindings/pinctrl/hisi.h               |  59 ++
>  5 files changed, 2149 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
>  create mode 100644 include/dt-bindings/pinctrl/hisi.h

The pinctrl changes need an Ack from the pinctrl maintainer.


-Olof
