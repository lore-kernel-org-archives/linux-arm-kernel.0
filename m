From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Sep 2014 09:42:00 +0100
Subject: [PATCH v2 3/4] arm64, thunder: Document devicetree bindings for
 Cavium Thunder SoC
In-Reply-To: <1409903205-2762-4-git-send-email-rric@kernel.org>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <1409903205-2762-4-git-send-email-rric@kernel.org>
Message-ID: <20140905084200.GE13515@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 08:46:44AM +0100, Robert Richter wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> This patch adds documentation for the devicetree bindings used by the
> DT files of Cavium Thunder SoC platforms.
> 
> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  Documentation/devicetree/bindings/arm/cavium-thunder.txt | 10 ++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt           |  1 +
>  2 files changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder.txt b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
> new file mode 100644
> index 000000000000..6f63a5866902
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
> @@ -0,0 +1,10 @@
> +Cavium Thunder platform device tree bindings
> +--------------------------------------------
> +
> +Boards with Cavium's Thunder SoC shall have following properties.
> +
> +Root Node
> +---------
> +Required root node properties:
> +
> +  - compatible = "cavium,thunder-88xx";

Is this file necessary? We don't have one for xgene afaict.

Will
