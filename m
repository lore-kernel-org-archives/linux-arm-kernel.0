From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 02 Aug 2018 13:50:05 -0700
Subject: [PATCH] clk: scmi: Fix the rounding of clock rate
In-Reply-To: <1533016555-3731-1-git-send-email-amit.kachhap@arm.com>
References: <153296797329.17365.14490424418553594815@swboyd.mtv.corp.google.com>
 <1533016555-3731-1-git-send-email-amit.kachhap@arm.com>
Message-ID: <153324300559.10763.831180927555837774@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Amit Daniel Kachhap (2018-07-30 22:55:55)
> This fix rounds the clock rate properly by using quotient and not
> remainder in the calculation. This issue was found while testing HDMI
> in the Juno platform.
> 
> Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---

Applied to clk-next
