From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Sep 2015 17:35:40 +0100
Subject: [PATCH v4 0/5] irqchip, gicv3: Updates and Cavium ThunderX errata
 workarounds
In-Reply-To: <1439576885-15621-1-git-send-email-rric@kernel.org>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
Message-ID: <55EDBCDC.5090901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 14/08/15 19:28, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This patch series adds gicv3 updates and workarounds for HW errata in
> Cavium's ThunderX GICV3.
> 
> The first one is an unchanged resubmission of a patch from a gicv3
> series I sent a while ago.
> 
> The next patches implement the workarounds for ThunderX's gicv3. Patch
> #2 implements the cpu workaround for gicv3 on ThunderX. Patch #3 is a
> prerequisit for patch #5. Patch #4 adds generic code to parse the hw
> revision provided by an IIDR. This patch is used for the implementa-
> tion of the actual gicv3-its workaround in #5.
> 
> All current review comments addressed so far with v4.

There has been a small number of comments on this series. Would you mind
respining it so that it could make it a a 4.3-rc?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
