From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 21:59:45 +0900
Subject: [PATCH v2 6/6] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <2236509.stVfXyPhpt@amdc1227>
References: <201307100057.06061.heiko@sntech.de>
 <201307100100.28992.heiko@sntech.de>
 <02cf01ce81f3$6777e5f0$3667b1d0$%kim@samsung.com>
 <2236509.stVfXyPhpt@amdc1227>
Message-ID: <0ee601ce886d$abb6a690$0323f3b0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:

[...]

> > > +	timer at 51000000 {
> > > +		clocks = <&clocks PCLK_PWM>;
> >
> > +		clocks = <&clock PCLK_PWM>;
> >
> > And I'm not sure using definition PCLK_PWM is better here...
> 
> Care to explain your doubts about it? I think this is fine.
> 
I mean I don't know why someone use a hard value(number) and someone use the
definition...

- Kukjin
