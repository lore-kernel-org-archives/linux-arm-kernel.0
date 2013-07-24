From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 24 Jul 2013 16:01:18 +0200
Subject: [PATCH v2 6/6] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <0ee601ce886d$abb6a690$0323f3b0$@org>
References: <201307100057.06061.heiko@sntech.de> <2236509.stVfXyPhpt@amdc1227>
 <0ee601ce886d$abb6a690$0323f3b0$@org>
Message-ID: <2889437.fCIi7koiPh@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 of July 2013 21:59:45 Kukjin Kim wrote:
> Tomasz Figa wrote:
> 
> [...]
> 
> > > > +	timer at 51000000 {
> > > > +		clocks = <&clocks PCLK_PWM>;
> > > 
> > > +		clocks = <&clock PCLK_PWM>;
> > > 
> > > And I'm not sure using definition PCLK_PWM is better here...
> > 
> > Care to explain your doubts about it? I think this is fine.
> 
> I mean I don't know why someone use a hard value(number) and someone use
> the definition...

Since preprocessor support for dts files was introduced, definitions are 
preferred, wherever possible to specify constants.

Best regards,
Tomasz
