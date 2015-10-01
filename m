From: robherring2@gmail.com (Rob Herring)
Date: Thu, 1 Oct 2015 08:18:37 -0500
Subject: [PATCH 2/4] of: documentation: add bindings documentation for
 Meson8b
In-Reply-To: <1443699514-11590-3-git-send-email-carlo@caione.org>
References: <1443699514-11590-1-git-send-email-carlo@caione.org>
 <1443699514-11590-3-git-send-email-carlo@caione.org>
Message-ID: <CAL_JsqK4wjfbwvYmB459OhyqJpWgm6GtR3PtsDqiH2QE+FJ_ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2015 at 6:38 AM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 973884a..b1a6444 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -9,6 +9,12 @@ Boards with the Amlogic Meson8 SoC shall have the following properties:
>    Required root node property:
>      compatible: "amlogic,meson8";
>
> +Boards with the Amlogic Meson8b SoC shall have the following properties:
> +  Required root node property:
> +    compatible: "amlogic,meson8b";
> +
>  Board compatible values:
>    - "geniatech,atv1200"
>    - "minix,neo-x8"
> +  - "tronfy,mxq"
> +  - "hardkernel,odroid-c1"

It would be good to separate which board compatibles apply to which SOC.

Rob
