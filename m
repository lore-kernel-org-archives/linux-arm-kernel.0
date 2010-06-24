From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 24 Jun 2010 20:51:27 +0200
Subject: [PATCH 3/4] pxa2xx/cpufreq: Fix PCMCIA frequency scaling
In-Reply-To: <87mxulabaw.fsf@free.fr>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
	<1276840135-5982-3-git-send-email-marek.vasut@gmail.com>
	<87mxulabaw.fsf@free.fr>
Message-ID: <201006242051.27790.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 23. ?ervna 2010 19:49:59 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > The MCxx values must be based off memory clock, not CPU core clock.
> > 
> > This also fixes the bug where on some machines the LCD went crazy while
> > using PCMCIA.
> 
> That looks correct to me.
> 
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Cheers.
> 
> --
> Robert

Actually lemme rethink this ... it might still be incorrect.
