From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 22:12:15 +0200
Subject: [PATCH v2 1/4] dt-bindings: add sunxi SPDIF transceiver bindings
In-Reply-To: <1443635458-8873-2-git-send-email-codekipper@gmail.com>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
 <1443635458-8873-2-git-send-email-codekipper@gmail.com>
Message-ID: <20151001201215.GN7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 07:50:55PM +0200, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add devicetree bindings for the SPDIF transceiver found on
> found on Allwinners A10, A20 and A31 SoCs.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  .../devicetree/bindings/sound/sunxi,spdif.txt      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/sunxi,spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
> new file mode 100644
> index 0000000..1868722
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
> @@ -0,0 +1,49 @@
> +Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +The Allwinner S/PDIF audio block is a transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.
> +
> +Required properties:
> +
> +  - compatible		: should be one of the following:
> +    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> +    - "allwinner,sun7i-a20-spdif": for the Allwinner A20 SoC
> +    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC

Are all these compatibles really work? Is there any significant
difference between the controller on all these SoCs?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/30054a00/attachment.sig>
