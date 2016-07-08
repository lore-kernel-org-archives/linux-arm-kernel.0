From: andi@etezian.org (Andi Shyti)
Date: Sat, 9 Jul 2016 01:35:09 +0900
Subject: [PATCH v2 6/7] spi: s3c64xx: restore removed comments
In-Reply-To: <146799464881.73491.7507792367941552864@resonance>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
 <146799464881.73491.7507792367941552864@resonance>
Message-ID: <20160708163509.GE1256@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

> >         if (sdd->port_conf->clk_from_cmu) {
> > +               /* There is half-multiplier before the SPI */
> >                 clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> 
> Just a small comment, but if the fixed-factor divide-by-two clock was
> modeled in Linux, then this driver could call clk_set_rate on that clock
> with the "correct" rate.
> 
> I guess that this driver would be the provider of that clock?

Makes sense, I will check it.

Thanks again,
Andi
