From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 3 Apr 2014 16:22:02 +0800
Subject: [PATCH 2/3] ARM: dts: document the berlin enable-method property
In-Reply-To: <1396512496-8030-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1396512496-8030-1-git-send-email-antoine.tenart@free-electrons.com>
 <1396512496-8030-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140403162202.79b63729@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 3 Apr 2014 01:08:15 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
> b/Documentation/devicetree/bindings/arm/cpus.txt index
> 333f4aea3029..a9e42a2dbc99 100644 ---
> a/Documentation/devicetree/bindings/arm/cpus.txt +++
> b/Documentation/devicetree/bindings/arm/cpus.txt @@ -185,6 +185,8 @@ nodes
> to be present and contain the properties described below. "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "marvell,88de31-smp" - cpu-core handling for

why not "marvell,berlin-smp"? 

Thanks
