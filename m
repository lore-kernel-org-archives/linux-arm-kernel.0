From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Dec 2013 08:23:43 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <529D7838.6030606@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com>
 <5298AA23.7080404@st.com> <529C5BBF.6000604@freescale.com>
 <529C6CBB.4000008@st.com> <529D7838.6030606@freescale.com>
Message-ID: <20131203082343.GK31626@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >To be honest, I am just glad that someone is taking a look at this area.
> >However, whether or not is it possible to come up with something that solves all
> >our problems remains to be seen.  It might turn out that the various H/W
> >Controllers are just too different to fit into a single unified framework.
> >
> Hi Angus & Pekon:
> thanks for the explanations.
> 
> I am not sure that after we add more hooks, if it will meet Jones's
> new driver.

Angus is the author of "Lee's" driver and knows more about it that I
ever will, so whatever he says goes in that regard.

I would like to make a suggestion to Brian though. Even if the new
framework is written within the next couple of months and the
semantics do suit the FSM Controller driver, I'd still like the
implementation that's currently on the list to be applied. That way
we'd have a known good version of the driver which is almost identical
to how ST's internal driver does now. The one that is present out in
the wild (i.e. _real_ products).

I will subsequently volunteer to provide my utmost best efforts to
port the driver over to the new framework as a new task once it has
landed.

> i will wait for Jones' comment for several days, and send out the
> next version if he does not reply this thread.

/me waves \o/

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
