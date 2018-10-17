From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 10:49:44 -0700
Subject: [PATCH v2 03/22] clk: at91: h32mx: separate registration from DT
 parsing
In-Reply-To: <20181016142200.19741-4-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <20181016142200.19741-4-alexandre.belloni@bootlin.com>
Message-ID: <153979858426.5275.4470807773156953838@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alexandre Belloni (2018-10-16 07:21:41)
> Separate registration out of of_sama5d4_clk_h32mx_setup to allow other code
> to use it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
