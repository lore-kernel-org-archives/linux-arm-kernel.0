From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Feb 2016 13:01:19 -0200
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <20160211084029.GE13664@pengutronix.de>
References: <20160127105613.GC13664@pengutronix.de>
 <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
 <20160127144340.GD13664@pengutronix.de>
 <CAOMZO5AE6HwBYz7kOFORt0HTojJLSb0MYUbkb_HCshDHy=d27g@mail.gmail.com>
 <20160210150315.GC13664@pengutronix.de>
 <CAOMZO5D5H4F90nse9kyW9KvsJStN-sCGktup4FDPw_zTeNfS2g@mail.gmail.com>
 <20160211084029.GE13664@pengutronix.de>
Message-ID: <CAOMZO5BDjkWi+cQK1-J7ag8Z48tY1Uwofi4EkovN-drSC4_reA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 6:40 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> root at hostname:/sys/kernel/debug/clk find -name saif?_sel
> ./ref_xtal/pll0/saif0_sel
> ./ref_xtal/pll0/saif1_sel
>
> root at hostname:/sys/kernel/debug/clk cat ./ref_xtal/pll0/saif?_sel/clk_rate
> 480000000
> 480000000

Ok, what about the SAIF0 and SAIF1 sampling rates: are they always the same?
