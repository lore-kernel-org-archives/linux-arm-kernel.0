From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Oct 2013 14:03:19 +0100
Subject: [PATCH] Documentation: add moxa vendor prefix
In-Reply-To: <1381237000-8398-1-git-send-email-jonas.jensen@gmail.com>
References: <1381237000-8398-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20131008130318.GB1412@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 01:56:40PM +0100, Jonas Jensen wrote:
> Add moxa vendor prefix.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
> 
> Notes:
>     Submitting this per Mark Rutland's request.
>     
>     Applies to next-20130927
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2956800..0a04e89 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -40,6 +40,7 @@ marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
>  microchip	Microchip Technology Inc.
>  mosaixtech	Mosaix Technologies, Inc.
> +moxa	Moxa Technology Co., Ltd.

Should this not be Moxa _Technologies_ Co., Ltd? (judging by a quick
search).

Otherwise, this looks fine to me.

Mark.

>  national	National Semiconductor
>  nintendo	Nintendo
>  nvidia	NVIDIA
> -- 
> 1.8.2.1
> 
> 
