From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 23 Jun 2010 19:49:59 +0200
Subject: [PATCH 3/4] pxa2xx/cpufreq: Fix PCMCIA frequency scaling
In-Reply-To: <1276840135-5982-3-git-send-email-marek.vasut@gmail.com> (Marek
	Vasut's message of "Fri\, 18 Jun 2010 07\:48\:54 +0200")
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
	<1276840135-5982-3-git-send-email-marek.vasut@gmail.com>
Message-ID: <87mxulabaw.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> The MCxx values must be based off memory clock, not CPU core clock.
>
> This also fixes the bug where on some machines the LCD went crazy while using
> PCMCIA.
That looks correct to me.

Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
