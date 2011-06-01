From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 1 Jun 2011 12:48:51 +0530
Subject: [PATCH] OMAP: clockdomain: Remove redundant call to
	pwrdm_wait_transition()
In-Reply-To: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
References: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703718FBAF9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday, May 26, 2011 4:08 PM, Bedia, Vaibhav wrote:
> The call to pwrdm_wait_transition() in clkdm_clk_enable() is
> redundant since the function pwrdm_clkdm_state_switch() which
> is called next also does the same thing.  
> 

Any comments on this patch? Can it be merged?

Regards,
Vaibhav
