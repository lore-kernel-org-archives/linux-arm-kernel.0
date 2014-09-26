From: sre@ring0.de (Sebastian Reichel)
Date: Fri, 26 Sep 2014 17:57:25 +0200
Subject: [PATCH 2/5] power: reset: st: Provide DT bindings for ST's Power
 Reset driver
In-Reply-To: <1406040752-25229-3-git-send-email-lee.jones@linaro.org>
References: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
 <1406040752-25229-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20140926155724.GC21641@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 22, 2014 at 03:52:29PM +0100, Lee Jones wrote:
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/reset/st-reset.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/st-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/st-reset.txt b/Documentation/devicetree/bindings/power/reset/st-reset.txt
> new file mode 100644
> index 0000000..809af54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/st-reset.txt
> @@ -0,0 +1,11 @@
> +*Device-Tree bindings for ST SW reset functionality
> +
> +Required properties:
> +- compatible: should be "st,<chip>-restart".
> +- st,syscfg: should be a phandle of the syscfg node.
> +
> +Example node:
> +	restart {
> +		compatible = "st,stih416-restart";
> +		st,syscfg = <&syscfg_sbc>;
> +	};

http://git.infradead.org/battery-2.6.git/commit/b08fec2262c8dbb349fe9456586cf0724407e5ee

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/57d03813/attachment.sig>
