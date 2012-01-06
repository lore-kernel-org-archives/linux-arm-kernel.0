From: rusko.peter@prolan.hu (Peter Rusko)
Date: Fri, 6 Jan 2012 12:08:51 +0100
Subject: MX28 fec clock frequency
Message-ID: <4F06D643.6080602@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm trying to get the fec clock frequency on the i.MX28 processor. I0
need it for a PTP clock and it seems that I get a wrong value:
clk_get_rate returns 151578947.

I've tried to get all the clock rates up to the crystal clock through
the parent field and got these results:

CLKRATE: 151578947
CLKRATE: 151578947
CLKRATE: 454736842
CLKRATE: 454736842
CLKRATE: 480000000
CLKRATE: 24000000

The first one is the fec_enet_private's clock and then the parents. Are
these correct values?

I'm currently using the master branch from git.pengutronix.de/git/imx

-- 
Rusk? P?ter
Fejleszt?m?rn?k

Prolan Zrt. / Prolan Co.
Hungary 2011 Budakal?sz, Szentendrei ?t 1-3.
Tel./Phone: +36 20 954 3118
Fax: +36 26 540 420
E-mail: rusko.peter at prolan.hu
Web: www.prolan.hu
Timezone:CET
