From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Jun 2018 14:56:31 +0100
Subject: [PATCH v10 13/14] cpufreq: Add module to register cpufreq on
 Krait CPUs
In-Reply-To: <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
 <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
Message-ID: <f195e30e-bef3-9352-9584-fec35631ec5e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/06/18 14:45, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
> 

Just curious to know how different is this from qcom kryo driver
that was added recently. IIRC even that gets the speedbin from nvmem.
Can they be merged ? I don't see need to have different driver for Krait
and Kryo CPUs when the code is not even remotely related to CPU type.

Sorry if I have missed anything from previous versions, I just happen
to open and looked at this series first time today.

-- 
Regards,
Sudeep
