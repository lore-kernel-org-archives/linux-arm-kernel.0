From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 13:53:53 -0700
Subject: [PATCH v4 1/2] clk: pxa: export 32kHz PLL
In-Reply-To: <20180627194124.26366-1-robert.jarzmik@free.fr>
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
Message-ID: <153091043355.143105.4051882411997045585@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2018-06-27 12:41:23)
> This clock is especially used by the RTC driver, so export it so that
> devicetree users can use it.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Applied to clk-next
