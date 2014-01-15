From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jan 2014 16:58:26 +0000
Subject: [PATCH v3 4/7] ARM: brcmstb: add CPU binding for Broadcom Brahma15
In-Reply-To: <1389743333-16741-5-git-send-email-marc.ceeeee@gmail.com>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <1389743333-16741-5-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <20140115165825.GJ25824@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 11:48:50PM +0000, Marc Carino wrote:
> Add the Broadcom Brahma B15 CPU to the DT CPU binding list.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 9130435..423b879 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -163,6 +163,7 @@ nodes to be present and contain the properties described below.
>  			    "arm,cortex-r4"
>  			    "arm,cortex-r5"
>  			    "arm,cortex-r7"
> +			    "brcm,brahma15"

Given all the documentation I can find online calls the CPU
"Brahma-B15", would it not make more sense for this to be
"brcm,brahma-b15"? 

That would match what we do for the ARM Cortex-[ar]\d processors.

Otherwise, this looks fine to me.

Cheers,
Mark.
