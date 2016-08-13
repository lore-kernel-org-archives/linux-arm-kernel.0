From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Aug 2016 16:36:10 +0800
Subject: [PATCH] Documentation: sunxi: Update Allwinner SoC documentation
In-Reply-To: <20160802120117.4848-1-icenowy@aosc.xyz>
References: <20160802120117.4848-1-icenowy@aosc.xyz>
Message-ID: <CAGb2v64BqQ9d7sb=ry56YjznuFiNT0AogDO4a6nUZut+H5jVFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 2, 2016 at 8:01 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Now, the A83T and A64 SoC user manuals are available.
> Update the documentation to add the links.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  Documentation/arm/sunxi/README | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
> index e5a115f..302d947 100644
> --- a/Documentation/arm/sunxi/README
> +++ b/Documentation/arm/sunxi/README
> @@ -74,3 +74,12 @@ SunXi family
>        - Allwinner A83T
>          + Datasheet
>            http://dl.linux-sunxi.org/A83T/A83T_datasheet_Revision_1.1.pdf
> +        + User Manual
> +          https://github.com/allwinner-zh/documents/raw/master/A83T/A83T_User_Manual_v1.5.1_20150513.pdf

Allwinner's github repo also has an updated A83T datasheet.
Could you update the link above as well?

Thanks
ChenYu

> +
> +    * Quad ARM Cortex-A53 based SoCs
> +      - Allwinner A64
> +        + Datasheet
> +          http://dl.linux-sunxi.org/A64/A64_Datasheet_V1.1.pdf
> +        + User Manual
> +          http://dl.linux-sunxi.org/A64/Allwinner%20A64%20User%20Manual%20v1.0.pdf
> --
> 2.9.0
>
