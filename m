From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Sep 2016 12:23:34 -0700
Subject: [PATCH 1/4] clk: pxa25x: OSTIMER0 clocks from the main oscillator
In-Reply-To: <1474312335-20997-2-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160919192334.GF7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19, Robert Jarzmik wrote:
> From: Russell King - ARM Linux <linux@armlinux.org.uk>
> 
> The OSTIMER0 clock ticks at the main oscillator rate, not the 32kHz
> oscillator rate.  Ensure that it is parented to the main oscillator.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
