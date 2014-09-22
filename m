From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 22 Sep 2014 11:04:25 +0200
Subject: [PATCHv3 1/7] clk: at91: add a driver for the h32mx clock
In-Reply-To: <541C228F.70207@atmel.com>
References: <1410797759-18675-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410797759-18675-2-git-send-email-alexandre.belloni@free-electrons.com>
 <541C228F.70207@atmel.com>
Message-ID: <20140922110425.2ec8a0af@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Sep 2014 14:33:19 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> On 15/09/2014 18:15, Alexandre Belloni :
> > Newer SoCs have two different AHB interconnect. The AHB 32 bits Matrix
> > interconnect (h32mx) has a clock that can be setup at the half of the h64mx
> > clock (which is mck). The h32mx clock can not exceed 90 MHz.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Okay on my side:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> 
> > ---
> > Cc:Mike Turquette <mturquette@linaro.org>
> 
> Mike,
> 
> I guess that you didn't get this v3. Can you "Ack" this one of should we
> re-sent to you?
> 
> I would like to take this patch with the rest of the SAMA5D4 series: is
> it okay for you?


Hi Mike,

I gave my ack to this patch, so, if you don't mind letting Nicolas
take it through his tree, I think it will ease integration of the
sama5d4 support (no external dependencies on the clk tree).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
