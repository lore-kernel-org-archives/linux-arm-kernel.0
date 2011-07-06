From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Jul 2011 23:35:57 -0600 (MDT)
Subject: [PATCH] OMAP: clockdomain: Remove redundant call to
	pwrdm_wait_transition()
In-Reply-To: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
References: <1306406290-25055-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <alpine.DEB.2.00.1107052334560.4217@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 May 2011, Vaibhav Bedia wrote:

> The call to pwrdm_wait_transition() in clkdm_clk_enable()
> is redundant since the function pwrdm_clkdm_state_switch()
> which is called next also does the same thing.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'clockdomain_a_3.1' branch.


- Paul
