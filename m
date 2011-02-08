From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Feb 2011 21:58:57 -0700 (MST)
Subject: [PATCH v2 9/9] omap4: clockdomain: Fix the CPUx domain name
In-Reply-To: <1296813544-25170-10-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-10-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1102072157030.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> The register naming convention for clock domain control inside
> power domain instance is:
> OMAPXXXX_<partition>_<power_domain>_<clock_domain>_CDOFFS
> 
> Both CPU0 and CPU1 use MPU as clock domain name instead of CPU0
> and CPU1.
> 
> Change the name to stick to the convention.
> The autogen scripts are updated accordingly.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 2.6.39 in the 'pwrdm_clkdm_b_2.6.39' branch of 
git://git.pwsan.com/linux-2.6 (along with patch 2/9).


- Paul
