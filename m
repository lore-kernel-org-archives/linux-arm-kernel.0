From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 2 Oct 2017 12:25:38 +0100
Subject: [PATCH 0/5] firmware: arm_scpi: series with smaller improvements
In-Reply-To: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
Message-ID: <18e22585-801a-18e7-a42b-8e10035abc37@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/09/17 22:25, Heiner Kallweit wrote:
> This series includes smaller improvements to make all memory allocations
> device-managed and eventually get rid of scpi_remove. This also improves
> the cleanup path in scpi_probe.
> 
Overall looks good, just one question on DVFS in patch 3. I vaguely
remember the need to support that in past.

-- 
Regards,
Sudeep
