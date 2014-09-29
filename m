From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 15:30:34 +0200
Subject: [PATCH 6/6] Documentation: Add entry for Spreadtrum's Shark64 SoC
In-Reply-To: <1411992293-7729-7-git-send-email-zhang.lyra@gmail.com>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-7-git-send-email-zhang.lyra@gmail.com>
Message-ID: <7195852.7nSHtIu8oc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 20:04:53 zhang.lyra at gmail.com wrote:
> diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
> new file mode 100644
> index 0000000..b6dc143
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sprd.txt
> @@ -0,0 +1,6 @@
> +Spreadtrum Platforms Device Tree Bindings
> +----------------------------------------------------
> +
> +Shark64 Board
> +Required root node properties:
> +        - compatible = "sprd,shark64";
> 

Is Shark a board or an SOC? The subject line of the patch and the contents
seem to disagree here.

It's generally better to have the exact SoC product numbers in here, e.g.
"sprd,sc1234", in case we have to apply fixups based on the SoC. You should
also have a board specific string in addition to the SoC-specific one.

	Arnd
