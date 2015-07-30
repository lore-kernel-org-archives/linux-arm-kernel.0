From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 30 Jul 2015 11:41:34 +0200
Subject: [PATCH 19/20] clocksource: atmel-st: get and use slow clock
In-Reply-To: <1438215726-27452-20-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438215726-27452-20-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150730114134.0f26f9e9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Thu, 30 Jul 2015 02:22:05 +0200, Alexandre Belloni wrote:

> -#define AT91_SLOW_CLOCK		32768
> -#define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
> +struct clk *sclk;
> +int timer_latch;

static ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
