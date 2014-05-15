From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 15 May 2014 12:33:11 -0300
Subject: [PATCH v5 0/5] mfd: add basic sun6i A31 PRCM support
In-Reply-To: <1400144113-27659-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1400144113-27659-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <5374DE37.3030700@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

El 15/05/14 05:55, Boris BREZILLON escribi?:
> Hello,
>
> This patch series adds support for some functions provided by the PRCM
> (Power/Reset/Clock Management) unit:
> - AR100, AHB0 and APB0 clocks
> - APB0 reset controller
(snip)
>    clk: sunxi: add PRCM (Power/Reset/Clock Management) clks support
>    clk: sunxi: document PRCM clock compatible strings

I have taken these two on sunxi-clk-for-mike, and I'll be sending the 
pull to Mike soon.

Cheers,

Emilio
