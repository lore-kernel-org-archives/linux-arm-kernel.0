From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 10 Dec 2010 16:54:04 +0100
Subject: [PATCH 0/5] OMAP4: hwmod data fixes and update
In-Reply-To: <87hbem4g76.fsf@deeprootsystems.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
	<87hbem4g76.fsf@deeprootsystems.com>
Message-ID: <4D024D1C.2020703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2010 1:36 AM, Kevin Hilman wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:

[...]

> As with the other series, I tried to pull this into my pm-core for
> testing with all the other PM stuff we have baking for 2.6.38.
>
> Unfortunately, this series has conflicts with Paul's
> pwrdm_prcm_[ab]_2.6.38 branches.
>
> Could you rebase this on Paul's pwrdm_prcm_b_2.6.38 branch?

- for_2.6.38/clock is now rebased on top of pwrdm_prcm_b_2.6.38
- for_2.6.38/hwmod_data is rebased on top of for_2.6.38/clock

Regards,
Benoit
