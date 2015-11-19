From: pramodku@broadcom.com (Pramod Kumar)
Date: Thu, 19 Nov 2015 03:34:58 +0000
Subject: [PATCH 03/11] dts: pinctrl: Add GPIO to Pinctrl pin mapping in DT
In-Reply-To: <564CC5E2.2070809@gmail.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-4-git-send-email-pramodku@broadcom.com>
 <564CC5E2.2070809@gmail.com>
Message-ID: <0C803592FC378B4E83922050AB46442A2AD9ECBD@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> Sent: 19 November 2015 00:10
> To: Pramod Kumar; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell;
> Kumar Gala; Ray Jui; Scott Branden; Russell King; Linus Walleij; linux-
> gpio at vger.kernel.org
> Cc: bcm-kernel-feedback-list; Jason Uy; Masahiro Yamada; Thomas Gleixner;
> Laurent Pinchart; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jonas Gorski
> Subject: Re: [PATCH 03/11] dts: pinctrl: Add GPIO to Pinctrl pin mapping in DT
> 
> On 18/10/15 22:43, Pramod Kumar wrote:
> > ASIU gpio controller's pins are muxed with pin-cntroller.
> > Add this mapping through property "gpio-ranges".
> >
> > Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> > Reviewed-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 
> Applied to devicetree/next, since there was a bit of restructuring, I had to
> manually apply it, please verify the resolution looks correct to you.

Applied patch looks fine. Thanks for having time in restructuring. 

Regards,
Pramod

> 
> Thanks!
> --
> Florian
