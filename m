From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 14:05:44 -0700
Subject: [PATCH 05/61] clk: samsung: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
Message-ID: <152641834430.237094.6970165334408131900@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Wolfram Sang (2018-04-19 07:05:35)
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied to clk-next
