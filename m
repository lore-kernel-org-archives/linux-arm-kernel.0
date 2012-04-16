From: Hong.Xu@atmel.com (Xu, Hong)
Date: Mon, 16 Apr 2012 01:56:22 +0000
Subject: [PATCH 1/4] AT91: Add DT description files for AT91SAM9N12-EK
In-Reply-To: <4F8683AB.5000004@atmel.com>
References: <1334211996-31572-1-git-send-email-hong.xu@atmel.com>
 <1334211996-31572-2-git-send-email-hong.xu@atmel.com>
 <4F8683AB.5000004@atmel.com>
Message-ID: <A92DB5DF46DBC241980A99BFD8A00AEE0F6291FE@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludo,

> -----Original Message-----
> From: Ludovic Desroches [mailto:ludovic.desroches at atmel.com]
> Sent: Thursday, April 12, 2012 3:27 PM
> To: Xu, Hong
> Cc: Ferre, Nicolas; plagnioj at jcrosoft.com;
> linux-arm-kernel at lists.infradead.org; Desroches, Ludovic
> Subject: Re: [PATCH 1/4] AT91: Add DT description files for AT91SAM9N12-EK
> 
> Hi,
> 
> Le 04/12/2012 08:26 AM, Hong Xu a ?crit :
>  > Added AT91SAM9N12 SoC DT file, as well as the board definition file
>  > for AT91SAM9N12-EK
>  >
>  > Signed-off-by: Hong Xu<hong.xu@atmel.com>
>  > ---
>  >   arch/arm/boot/dts/at91sam9n12.dtsi  |  223
> +++++++++++++++++++++++++++++++++++
>  >   arch/arm/boot/dts/at91sam9n12ek.dts |  111 +++++++++++++++++
>  >   2 files changed, 334 insertions(+), 0 deletions(-)
>  >   create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
>  >   create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
>  >
[...]
>  > +
>  > +	memory at 20000000 {
>  > +		reg =<0x20000000 0x10000000>;
>  > +	};
> 
> Please remove unit address part. Explanations here:
> http://lists-archives.com/linux-kernel/27617260-arm-at91-dt-remove-unit-ad
> dress-part-for-memory-nodes.html
> 

OK.

> [...]
> 
>  > diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts
> b/arch/arm/boot/dts/at91sam9n12ek.dts
>  > new file mode 100644
>  > index 0000000..56b012f
>  > --- /dev/null
>  > +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
>  > @@ -0,0 +1,111 @@
[...]
>  > +
>  > +	memory at 20000000 {
>  > +		reg =<0x20000000 0x10000000>;
>  > +	};
> 
> ditto

OK

Thanks

BR,
Eric
> 
> [...]
> 
> Regards
> 
> Ludovic
