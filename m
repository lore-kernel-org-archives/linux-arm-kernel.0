From: arden.jay@gmail.com (arden jay)
Date: Sun, 30 Jan 2011 11:49:32 +0800
Subject: [RFC] add pwmlib support
In-Reply-To: <20110129215141.GA3493@pengutronix.de>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<20110129213821.0e51dc32@endymion.delvare>
	<20110129215141.GA3493@pengutronix.de>
Message-ID: <AANLkTi=ppKZ96T3_1nYisHG9705OCHgZqkLnu2f47zq5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I'm confused about this.
If it is for backlight control, why it don't go through led_class?

Do I miss anything?

2011/1/30 Wolfram Sang <w.sang@pengutronix.de>:
>
>> > code is inspired by gpiolib support and tested using the backlight pwm
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ^^^^^^^^^
>> So I believe that hwmon drivers are out of scope for pwmlib. Which
>> makes me wonder what you intend to do with pwmlib (back to my first
>> question...) as the only use I know of for PWM signals in computers is
>> for fan control.
>
> It was meant for backlight control (was mentioned very indirectly).
> I also pointed him to Bill's implementation, too.
>
> Regards,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAk1Ei+0ACgkQD27XaX1/VRvjkACeOhJonBEZQX8U+ihKtiMjQT/U
> IfAAoMdZiOrAOvuH1Iv6ZKNYoT+VhhTM
> =ROYN
> -----END PGP SIGNATURE-----
>
>



-- 
cheers,
jay
