From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 29 May 2013 19:07:12 +0000 (UTC)
Subject: [RFC PATCH 1/3] ARM: AM33XX: clock: Add debugSS clock nodes to
 clock tree
In-Reply-To: <1362396957-30113-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-2-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.02.1305291906160.9052@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Mar 2013, hvaibhav at ti.com wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Represent debugSS clock interface as provided in
> CM_WKUP_DEBUGSS_CLKCTRL register, which includes,
> 	- Clock gate for optional DEBUG_CLKA and DBGSYSCLK
> 	- Clock Mux for TRC_PMD and STM_PMD
> 	- Clock divider for STM and TPIU
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

based on a quick glance.


- Paul
