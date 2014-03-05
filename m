From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Mar 2014 19:27:22 +0100
Subject: [PATCH 04/15] iio: adc: at91_adc: Add support for touchscreens
 without TSMR
In-Reply-To: <1394040940-18246-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1394040940-18246-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140305192722.786d5549@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Wed,  5 Mar 2014 18:35:29 +0100, Alexandre Belloni wrote:

> -static irqreturn_t at91_adc_interrupt(int irq, void *private)
> +void handle_adc_rl_ts_irq(int irq, struct at91_adc_state *st, u32 status)

I believe this function,

> +void handle_adc_9x5_ts_irq(int irq, struct at91_adc_state *st, u32 status)

and this one should be 'static'.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
