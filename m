From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 30 Jul 2018 12:36:52 +0100
Subject: [PATCH] clk: scmi: Fix the rounding of clock rate
In-Reply-To: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com>
References: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com>
Message-ID: <20180730113652.GA16266@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 07:31:52PM +0530, Amit Daniel Kachhap wrote:
> This fix rounds the clock rate properly by using quotient and not
> remainder in the calculation. This issue was found while testing HDMI
> in the Juno platform.
>
Good find, thanks.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
