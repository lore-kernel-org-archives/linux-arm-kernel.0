From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 10:49:41 -0700
Subject: [PATCH v2 02/22] clk: at91: generated: SSCs don't have a gclk
In-Reply-To: <20181016142200.19741-3-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <20181016142200.19741-3-alexandre.belloni@bootlin.com>
Message-ID: <153979858157.5275.17839109512575751084@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alexandre Belloni (2018-10-16 07:21:40)
> As the SSCs don't have gclk, don't check for their ID to allow them to set
> the audio pll rate.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
