From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Wed, 17 Feb 2016 15:23:49 +0530
Subject: [PATCH v2 1/3] input: cygnus-update touchscreen dt node document
In-Reply-To: <13357929.DDBX61jLXt@wuerfel>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <13357929.DDBX61jLXt@wuerfel>
Message-ID: <b2adbdb45d34485fbe8a29f580ab0c61@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: 17 February 2016 15:16
> To: Raveendra Padasalagi
> Cc: Dmitry Torokhov; Russell King; Rob Herring;
devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-input at vger.kernel.org; Pawel
Moll;
> Mark Rutland; Ian Campbell; Kumar Gala; Jonathan Richardson; Jon Mason;
> Florian Fainelli; Anup Patel; Ray Jui; Scott Branden; linux-
> kernel at vger.kernel.org; bcm-kernel-feedback-list at broadcom.com
> Subject: Re: [PATCH v2 1/3] input: cygnus-update touchscreen dt node
> document
>
> On Wednesday 17 February 2016 15:13:44 Raveendra Padasalagi wrote:
> > +
> > +       ts_adc_syscon: ts_adc_syscon at 0x180a6000 {
> > +               compatible = "syscon";
> > +               reg = <0x180a6000 0xc30>;
> > +       };
> >
>
> This should have a more specific compatible string in addition to the
generic
> "syscon" one.

Ok, Thanks Arnd. I will address this in the next patch.

> 	Arnd
