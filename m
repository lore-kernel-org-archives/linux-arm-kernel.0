From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Oct 2015 21:02:36 +0300
Subject: [PATCH 0/5] ARM: dts: fix cpu compatible values
In-Reply-To: <1443202506-13732-1-git-send-email-vz@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
Message-ID: <5625303C.6090902@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.09.2015 20:35, Vladimir Zapolskiy wrote:
> The changeset corrects severeal cpu compatible properties
> to defined ones in Documentation/devicetree/bindings/arm/cpus.txt
> 
> Vladimir Zapolskiy (5):
>   ARM: dts: i.MX31: fix cpu compatible value
>   ARM: dts: i.MX35: fix cpu compatible value

Ping. Two patches above are applied by Shawn, could ARM maintainers
apply the rest? Thank you in advance.

>   ARM: dts: S3C2416: fix cpu compatible value
>   ARM: dts: TI-Nspire: fix cpu compatible value
>   ARM: dts: WM8750: fix cpu compatible value
> 
>  arch/arm/boot/dts/imx31.dtsi   | 2 +-
>  arch/arm/boot/dts/imx35.dtsi   | 2 +-
>  arch/arm/boot/dts/nspire.dtsi  | 2 +-
>  arch/arm/boot/dts/s3c2416.dtsi | 2 +-
>  arch/arm/boot/dts/wm8750.dtsi  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

--
With best wishes,
Vladimir
