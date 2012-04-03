From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 3 Apr 2012 17:58:45 -0600 (MDT)
Subject: [PATCH 2/2] ARM: OMAP: powerdomain: Get rid off duplicate
 pwrdm_clkdm_state_switch() API
In-Reply-To: <1331562873-29535-3-git-send-email-santosh.shilimkar@ti.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
 <1331562873-29535-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1204031758340.8000@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Mar 2012, Santosh Shilimkar wrote:

> With patch 'ARM: OMAP: powerdomain: Wait for powerdomain transition
> in pwrdm_state_switch()', the pwrdm_clkdm_state_switch() API becomes
> duplicate of pwrdm_state_switch().
> 
> Get rid off duplicate pwrdm_clkdm_state_switch() and update the
> users of it with pwrdm_state_switch()
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Rajendra Nayak <rnayak@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>

Thanks, queued for 3.5.


- Paul
