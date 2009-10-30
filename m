From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 30 Oct 2009 14:18:36 +0800
Subject: [PATCH] net: Fix checks on unsigned in w90p910_ether_probe()
In-Reply-To: <20091029.230624.125832796.davem@davemloft.net>
References: <4ADDFE0C.3020400@gmail.com>
	<20091029.230624.125832796.davem@davemloft.net>
Message-ID: <e68bb3470910292318j7a4d3e9fpcc9fe714a0561ef7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear sirs,

Okay, it is right, thanks all for your help.
I will re-fix it later.

2009/10/30, David Miller <davem@davemloft.net>:
> From: Roel Kluin <roel.kluin@gmail.com>
> Date: Tue, 20 Oct 2009 20:14:36 +0200
>
> > ether->txirq and ->rxirq are unsigned
> >
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>
> platform_get_irq() returns a signed int so the intention
> is more likely that catching negative value returns
> was intended.
>
> Probably the correct fix is to mark txirq and rxirq as
> plain 'int'.
>


-- 
Wan z.s
