From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 15 Mar 2010 23:24:09 +0200
Subject: [PATCH] ARM: SAMSUNG: Add suspend/resume support for S3C PWM
	driver
In-Reply-To: <4B9E9946.9030607@metafoo.de>
References: <1268663228-27515-1-git-send-email-anarsoul@gmail.com>
	<201003152217.02781.anarsoul@gmail.com>
	<4B9E9946.9030607@metafoo.de>
Message-ID: <201003152324.15260.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 15 ????? 2010 22:32:06 ????? Lars-Peter Clausen ???????:

> Hi
> 
> Because it would require to implement the same functionality over and
> over again. Furthermore it would require each generic driver using the
> pwm api to provide such callbacks.
> And you - as a user of the api - will have to know about this oddity.
> In my opinion it is a detail specific to the samsung platform and
> should be hidden behind the common interface.
> 
> - Lars

So, you want to configure corresponding GPIO pin as output and set it to low 
in pwm_disable, re-configure it as PWM output in pwm_enable, and 
disable/enable PWM during suspend/resume cycle? If so - it's easy to 
implement, but I want to hear Ben's opinion.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100315/a864c9ba/attachment.sig>
