From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Apr 2013 11:06:38 +0100
Subject: [PATCH V2 1/3] clk: ux500: Add support for sysctrl clocks
In-Reply-To: <1364982412-9853-1-git-send-email-ulf.hansson@stericsson.com>
References: <1364982412-9853-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130403100638.GD17995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 11:46:52AM +0200, Ulf Hansson wrote:
> +	clk_reg = devm_clk_register(clk->dev, &clk->hw);
> +	if (IS_ERR_OR_NULL(clk_reg)) {

Please go and read the devm_clk_register() code and work out whether
your check above is appropriate.  Thanks.
