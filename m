From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Dec 2013 13:13:27 +0000
Subject: [PATCH v4 02/15] clk: Allow drivers to pass in a regmap
In-Reply-To: <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131224131327.GF30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 05:12:26PM -0800, Stephen Boyd wrote:
> Add support to the clock core so that drivers can pass in a
> regmap. If no regmap is specified try to query the device that's
> registering the clock for its regmap. This should allow drivers
> to use the core regmap helpers. This is based on a similar design
> in the regulator framework.

Reviewed-by: Mark Brown <broonie@linaro.org>
