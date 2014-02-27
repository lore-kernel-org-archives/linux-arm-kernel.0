From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 08:35:01 +0000
Subject: [PATCH v4 4/8] mfd: ssbi: Add regmap read/write helpers
In-Reply-To: <1393441166-32692-5-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
 <1393441166-32692-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227083501.GX9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Stephen Boyd wrote:

> Add read and write helper functions that the pm8921-core driver
> can use to read and write ssbi registers via a "no-bus" regmap.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  include/linux/ssbi.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
