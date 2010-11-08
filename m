From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 8 Nov 2010 11:08:11 +0200
Subject: [PATCH v2] ARM: s3c2442: Setup gpio {set,get}_pull callbacks
In-Reply-To: <4CD57DC1.4050403@embtoolkit.org>
References: <1285020052-20020-1-git-send-email-lars@metafoo.de>
	<1289030074-5233-1-git-send-email-anarsoul@gmail.com>
	<4CD57DC1.4050403@embtoolkit.org>
Message-ID: <201011081108.12516.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 November 2010 18:09:37 Abdoulaye Walsimou GAYE wrote:

Restored CC list, please don't clean it next time.

> > -	.set_pull	= s3c_gpio_setpull_1up,
> > -	.get_pull	= s3c_gpio_getpull_1up,
> > 
> >   };
> 
> This part of your patch will prevent s3c2440 based boards to boot see [1]

Well, your patch breaks compilation for s3c2442 at all (see comment from my 
patch)

Ben, why machine-specific init is called before cpu init?

Regards
Vasily
