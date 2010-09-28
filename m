From: arun.murthy@stericsson.com (Arun MURTHY)
Date: Tue, 28 Sep 2010 12:48:12 +0200
Subject: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
In-Reply-To: <4CA1C6C4.20504@mvista.com>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
	<1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
	<4CA1C6C4.20504@mvista.com>
Message-ID: <F45880696056844FA6A73F415B568C69532DC2FC97@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > @@ -16,6 +16,7 @@ struct led_pwm {
> >   struct led_pwm_platform_data {
> >   	int			num_leds;
> >   	struct led_pwm	*leds;
> > +	char *name;
> >   };
> 
>     Shouldn't '*name'be aligned, at least with '*leds'?
Sure, will take care of this in the v2 patch.

Thanks and Regards,
Arun R Murthy
-------------
