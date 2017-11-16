From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Nov 2017 22:35:29 -0600
Subject: [PATCH v2 6/8] dt-bindings: power: Add Actions Semi S700 SPS
In-Reply-To: <20171113233427.5386-7-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
 <20171113233427.5386-7-afaerber@suse.de>
Message-ID: <20171116043529.hrrgiga4hpdsy2tc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 12:34:25AM +0100, Andreas F?rber wrote:
> Define power domains for Actions Semi S700 SoC Smart Power System (SPS).
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  .../devicetree/bindings/power/actions,owl-sps.txt    |  2 ++
>  include/dt-bindings/power/owl-s700-powergate.h       | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 include/dt-bindings/power/owl-s700-powergate.h
> 
> diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> index 007b9a7ae723..78edd63641e8 100644
> --- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> +++ b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> @@ -2,10 +2,12 @@ Actions Semi Owl Smart Power System (SPS)
>  
>  Required properties:
>  - compatible          :  "actions,s500-sps" for S500
> +                         "actions,s700-sps" for S700
>  - reg                 :  Offset and length of the register set for the device.
>  - #power-domain-cells :  Must be 1.
>                           See macros in:
>                            include/dt-bindings/power/owl-s500-powergate.h for S500
> +                          include/dt-bindings/power/owl-s700-powergate.h for S700
>  
>  
>  Example:
> diff --git a/include/dt-bindings/power/owl-s700-powergate.h b/include/dt-bindings/power/owl-s700-powergate.h
> new file mode 100644
> index 000000000000..4ded16bc074f
> --- /dev/null
> +++ b/include/dt-bindings/power/owl-s700-powergate.h
> @@ -0,0 +1,20 @@
> +/*
> + * Actions Semi S700 SPS
> + *
> + * Copyright (c) 2017 Andreas F?rber
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

The decree now for SPDX tags is make this the first line using "//".

Otherwise, 

Acked-by: Rob Herring <robh@kernel.org>
