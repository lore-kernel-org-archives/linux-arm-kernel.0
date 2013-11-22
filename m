From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 22 Nov 2013 10:23:56 +0100
Subject: [PATCH v3 4/5] regulator: max14577: Add regulator driver for Maxim
 14577
In-Reply-To: <20131122091639.GG23067@lee--X1>
References: <1385109972-28059-1-git-send-email-k.kozlowski@samsung.com>
 <1385109972-28059-5-git-send-email-k.kozlowski@samsung.com>
 <20131122091639.GG23067@lee--X1>
Message-ID: <1385112236.29083.3.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-22 at 09:16 +0000, Lee Jones wrote:
(...)
> On Fri, 22 Nov 2013, Krzysztof Kozlowski wrote:
> > --- a/include/linux/mfd/max14577.h
> > +++ b/include/linux/mfd/max14577.h
> > @@ -63,7 +63,6 @@ struct max14577_platform_data {
> >  
> >  	int (*set_gpio_pogo_cb) (int new_dev);
> >  
> > -	int num_regulators;
> 
> This doesn't belong in this patch.

Right, thank you.

Krzysztof Kozlowski
