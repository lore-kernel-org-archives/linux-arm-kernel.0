From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 15 Dec 2015 09:36:17 +0000
Subject: [PATCH] ARM: psci: Fix indentation in DT bindings
In-Reply-To: <1450169255-669-1-git-send-email-geert+renesas@glider.be>
References: <1450169255-669-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20151215093617.GA11725@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 09:47:35AM +0100, Geert Uytterhoeven wrote:
> Fix bogus indentation of the PSCI compatible values (each space was
> replaced by a TAB?).

Probably, I would remove question from the log.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/psci.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
> index a9adab84e2feb785..fb3a1dd2a9880bda 100644
> --- a/Documentation/devicetree/bindings/arm/psci.txt
> +++ b/Documentation/devicetree/bindings/arm/psci.txt
> @@ -23,17 +23,17 @@ Main node required properties:
>  
>   - compatible    : should contain at least one of:
>  
> -				 * "arm,psci" : for implementations complying to PSCI versions prior to
> -					0.2. For these cases function IDs must be provided.
> +     * "arm,psci" : for implementations complying to PSCI versions prior to
> +	0.2. For these cases function IDs must be provided.

	* "arm,psci" : for implementations complying to PSCI versions prior to
		       0.2. For these cases function IDs must be provided.

Can you indent like above please (all of them) ?

Other than that:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  
> -				 * "arm,psci-0.2" : for implementations complying to PSCI 0.2. Function
> -					IDs are not required and should be ignored by an OS with PSCI 0.2
> -					support, but are permitted to be present for compatibility with
> -					existing software when "arm,psci" is later in the compatible list.
> +     * "arm,psci-0.2" : for implementations complying to PSCI 0.2. Function
> +	IDs are not required and should be ignored by an OS with PSCI 0.2
> +	support, but are permitted to be present for compatibility with
> +	existing software when "arm,psci" is later in the compatible list.
>  
> -				* "arm,psci-1.0" : for implementations complying to PSCI 1.0. PSCI 1.0 is
> -					backward compatible with PSCI 0.2 with minor specification updates,
> -					as defined in the PSCI specification[2].
> +    * "arm,psci-1.0" : for implementations complying to PSCI 1.0. PSCI 1.0 is
> +	backward compatible with PSCI 0.2 with minor specification updates,
> +	as defined in the PSCI specification[2].
>  
>   - method        : The method of calling the PSCI firmware. Permitted
>                     values are:
> -- 
> 1.9.1
> 
