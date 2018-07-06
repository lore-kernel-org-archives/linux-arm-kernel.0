From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 13:52:06 -0700
Subject: [PATCH v4 1/2] clk: pxa: export 32kHz PLL
In-Reply-To: <87d0w2gsa5.fsf@belgarion.home>
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
 <87d0w2gsa5.fsf@belgarion.home>
Message-ID: <153091032623.143105.13689700534218065371@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2018-07-04 22:34:10)
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > This clock is especially used by the RTC driver, so export it so that
> > devicetree users can use it.
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > ---
> > Since v2: fix missing parenthesis in clk-pxa25x.c and clk-pxa3xx.c
> 
> Hi Michael and Stephen,
> 
> Could you have a look please ?
> 

I'll apply patch 1, and leave patch 2 to someone else?
