From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 3 Apr 2014 10:29:03 +0200
Subject: [PATCH 2/3] ARM: dts: document the berlin enable-method property
In-Reply-To: <1396512496-8030-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1396512496-8030-1-git-send-email-antoine.tenart@free-electrons.com>
 <1396512496-8030-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140403082903.GA4883@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 at 10:08:15 +0200, Antoine T?nart wrote :

Please write a quick commit message.

> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 333f4aea3029..a9e42a2dbc99 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -185,6 +185,8 @@ nodes to be present and contain the properties described below.
>  			    "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "marvell,88de31-smp" - cpu-core handling for Berlin
> +					SoC from Marvell starting with 88de31

I would also go for something else, marvell,88de31xx-smp or marvell,berlin-smp.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
