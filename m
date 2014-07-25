From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 25 Jul 2014 09:42:25 +0200
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <1406242820-20140-10-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-10-git-send-email-afaerber@suse.de>
Message-ID: <53D20A61.1050506@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 01:00 AM, Andreas F?rber wrote:
> The specification requires compatible = "adi,axi-spdif-1.00.a" but
> driver and example and file name indicate "adi,axi-spdif-tx-1.00.a".
> Change the specification to match the implementation.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   v2: New
>
>   Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
> index 46f3449..4eb7997 100644
> --- a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
> +++ b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
> @@ -1,7 +1,7 @@
>   ADI AXI-SPDIF controller
>
>   Required properties:
> - - compatible : Must be "adi,axi-spdif-1.00.a"
> + - compatible : Must be "adi,axi-spdif-tx-1.00.a"
>    - reg : Must contain SPDIF core's registers location and length
>    - clocks : Pairs of phandle and specifier referencing the controller's clocks.
>      The controller expects two clocks, the clock used for the AXI interface and
>
