From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 05 Jul 2018 07:34:10 +0200
Subject: [PATCH v4 1/2] clk: pxa: export 32kHz PLL
In-Reply-To: <20180627194124.26366-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Wed, 27 Jun 2018 21:41:23 +0200")
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
Message-ID: <87d0w2gsa5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> This clock is especially used by the RTC driver, so export it so that
> devicetree users can use it.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v2: fix missing parenthesis in clk-pxa25x.c and clk-pxa3xx.c

Hi Michael and Stephen,

Could you have a look please ?

Cheers.

--
Robert
