From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Jul 2012 17:54:39 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: am33xx: Fix the timer fck clock naming
 convention
In-Reply-To: <1342462158-15998-1-git-send-email-hvaibhav@ti.com>
References: <1342462158-15998-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1207161754230.28834@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jul 2012, Vaibhav Hiremath wrote:

> With commit ae6df418a21f3a361c5f9b878e32a8aba4e17692
> Sub: ARM: OMAP2+: dmtimer: cleanup fclk usage)
> The Timer functional clock naming convention has changed from
> gptX_fck => timerXfck, and so as the timer init function
> in mach-omap2/timer.c.
> OMAP4 clocktree also has changed accordingly.
> 
> AM33xx Clock Tree has been merged during rc3-4 timeframe,
> before above commit got merged, so similar change is required
> for AM33xx as well (Change the gptX_fck => timerX_fck).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks, this looks like 3.6-rc material, right?


- Paul
