From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 23:02:23 -0700
Subject: [PATCH v3 1/9] clk: actions: Cache regmap info in private clock
 descriptor
In-Reply-To: <20180810095113.25292-2-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
 <20180810095113.25292-2-manivannan.sadhasivam@linaro.org>
Message-ID: <153975614377.5275.13892464901714156121@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Manivannan Sadhasivam (2018-08-10 02:51:05)
> In order to support the reset controller, regmap info needs to
> be cached in the private clock descriptor, owl_clk_desc. Hence,
> save that and also make the clock descriptor struct non const.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
