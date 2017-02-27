From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 13:00:32 -0600
Subject: [PATCH 2/4] devicetree: Add vendor prefix for Kontron AG
In-Reply-To: <20170219202801.2082-3-plaes@plaes.org>
References: <20170219202801.2082-1-plaes@plaes.org>
 <20170219202801.2082-3-plaes@plaes.org>
Message-ID: <20170227190032.p32ophqwp5ffrrvu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2017 at 10:27:59PM +0200, Priit Laes wrote:
> Kontron AG is a German-based company designing and manufacturing
> embedded modules, computers and systems.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 16d3b5e..4dca895 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -154,7 +154,8 @@ jedec	JEDEC Solid State Technology Association
>  karo	Ka-Ro electronics GmbH
>  keithkoep	Keith & Koep GmbH
>  keymile	Keymile GmbH
> -kinetic Kinetic Technologies
> +kinetic	Kinetic Technologies

No doubt this needs re-formatting, but don't do that in this patch.

> +kontron	Kontron AG
>  kosagi	Sutajio Ko-Usagi PTE Ltd.
>  kyo	Kyocera Corporation
>  lacie	LaCie
> -- 
> 2.9.3
> 
