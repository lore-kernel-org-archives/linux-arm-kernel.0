From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 Nov 2016 16:20:28 +0000
Subject: [PATCH 1/3] ARM: dts: hip01: Remove skeleton.dtsi inclusion
In-Reply-To: <1477297890-34899-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1477297890-34899-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <582B35CC.5080004@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 2016/10/24 9:31, Kefeng Wang wrote:
> Since commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
> as deprecated"), remove deprecated skeleton.dtsi.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Applied all the 3 patches to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

>  arch/arm/boot/dts/hip01.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
> index 4e9562f..9d5fd5c 100644
> --- a/arch/arm/boot/dts/hip01.dtsi
> +++ b/arch/arm/boot/dts/hip01.dtsi
> @@ -11,8 +11,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include "skeleton.dtsi"
> -
>  / {
>  	interrupt-parent = <&gic>;
>  	#address-cells = <1>;
> 
