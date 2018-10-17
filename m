From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 10:50:01 -0700
Subject: [PATCH v2 09/22] clk: at91: add new DT lookup function
In-Reply-To: <20181016142200.19741-10-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <20181016142200.19741-10-alexandre.belloni@bootlin.com>
Message-ID: <153979860117.5275.17758173311420161028@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alexandre Belloni (2018-10-16 07:21:47)
> Add a new DT lookup function to lookup for PMC clocks.
> 
> Note that the #ifndef AT91_PMC_MOSCS section will be removed once all the
> platforms are converted.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
