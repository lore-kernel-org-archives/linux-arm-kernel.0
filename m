From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Jul 2014 23:17:51 +0900
Subject: [PATCH] ARM: Samsung: ADC: Move to
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <53BBDACB.6090601@samsung.com>
References: <1404155288-2787-1-git-send-email-anarsoul@gmail.com>
 <53BBDACB.6090601@samsung.com>
Message-ID: <03ba01cf9ab7$671cff40$3556fdc0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Vasily,
> 
> On 30.06.2014 21:08, Vasily Khoruzhick wrote:
> > Use clk_prepare_enable/clk_disable_unprepare to make the driver
> > work properly with common clock framework.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  arch/arm/plat-samsung/adc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
Looks good to me, will apply.

Thanks,
Kukjin
