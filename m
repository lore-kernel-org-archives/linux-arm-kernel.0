From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 1 Oct 2015 01:56:47 +0300
Subject: [PATCH 01/19] ARM: shmobile: Add silk device tree bindings
 documentation
In-Reply-To: <e5923ad92d0177202b85fc4c2f1ae1a3a01f5a76.1442536920.git.horms+renesas@verge.net.au>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
 <e5923ad92d0177202b85fc4c2f1ae1a3a01f5a76.1442536920.git.horms+renesas@verge.net.au>
Message-ID: <560C68AF.4050505@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2015 03:47 AM, Simon Horman wrote:

> Add Silk Device tree bindings Documentation, listing it as a supported board.
>
> This allows to use checkpatch to validate DTSes referring to the Silk board.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 2b9cb62838f2..1d70e78e7c80 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -55,3 +55,5 @@ Boards:
>       compatible = "renesas,lager", "renesas,r8a7790"
>     - Marzen
>       compatible = "renesas,marzen", "renesas,r8a7779"
> +  - Silk

    I'll have to fix this up to SILK (RTP0RC7794LCB00011S). Sorry, noticed too 
late. :-(

MBR, Sergei
