From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 19 Apr 2017 12:28:01 +0300
Subject: [PATCH v2 0/4] ARM: imx: Set LDO regulator supply
In-Reply-To: <cover.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
Message-ID: <1492594081.15137.0.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-04 at 20:04 +0300, Leonard Crestez wrote:
> Setting the LDO regulator parent is optional but beneficial. It will cause
> the PMIC output voltage to be dynamically set to the minimum input for the
> LDOs, this should be more efficient.
> 
> This propagation was introduced by:
> commit fc42112c0eaa ("regulator: core: Propagate voltage changes to supply
> regulators")
> 
> Changes since v1:
>  * Drop patch 1 since it only avoids logging a warning and the gpc driver
> is going through more changes.
>  * Initialize cpufreq->suspend_freq based on policy->max instead.
>  * Remove reference to ldo-bypass from suspend_freq patch message.

Hello,

This is a gentle reminder that this was sent ~2 weeks ago and patches 1
and 2 are still waiting (with no objections). Patches 3/4 were applied.

--
Regards,
Leonard
