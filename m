From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Dec 2013 13:14:39 +0000
Subject: [PATCH v4 03/15] clk: Add regmap core helpers for
 enable/disable/is_enabled
In-Reply-To: <1387847559-18330-4-git-send-email-sboyd@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131224131439.GG30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 05:12:27PM -0800, Stephen Boyd wrote:
> The clock framework already has support for simple gate clocks
> but if drivers want to use the gate clock functionality they need
> to wrap the gate clock in another struct and chain the ops by
> calling the gate ops from their own custom ops. Plus the gate

Reviewed-by: Mark Brown <broonie@linaro.org>
