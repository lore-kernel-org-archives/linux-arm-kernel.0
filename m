From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Sep 2016 17:34:52 -0700
Subject: [PATCH] clk: meson-gxbb: Export PWM related clocks for DT
In-Reply-To: <57CACA00.9010306@baylibre.com>
References: <1471870177-10609-1-git-send-email-narmstrong@baylibre.com>
 <57CACA00.9010306@baylibre.com>
Message-ID: <20160907003452.GR12510@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03, Neil Armstrong wrote:
> 
> 
> Le 22/08/2016 14:49, Neil Armstrong a ?crit :
> > Add the PWM related clocks in order to be referenced as PWM source
> > clocks.
> > 
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  drivers/clk/meson/gxbb.h              | 6 +++---
> >  include/dt-bindings/clock/gxbb-clkc.h | 3 +++
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> Dear Clock Maintainers,
> 
> Could you review this patch since it is a strong requirement to select the PWM clock parents over DT ?
> 

Looks fine to me. Did you want an ack or an immutable branch?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
