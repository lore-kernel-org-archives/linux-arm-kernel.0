From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Sep 2012 08:47:19 +0000
Subject: [PATCH 1/2] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <1347490900-8409-1-git-send-email-davidb@codeaurora.org>
References: <1347461906-13527-7-git-send-email-arnd@arndb.de>
 <1347490900-8409-1-git-send-email-davidb@codeaurora.org>
Message-ID: <201209130847.20087.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012, David Brown wrote:
> 
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Convert MSM SMP platforms to use the SoC descriptor to provide
> their SMP and CPU hotplug operations.
> 
> Cc: David Brown <davidb@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is an adaptation of this change on top of the msm-for-3.7 tree I
> recently sent out a pull request for.  The only real change is to
> resolve the conflicts with the simplified board files.

Not sure what I'm supposed to do with this patch, it doesn't apply
unless I rebase all of the SMP patches on top of your msm-for-3.7 branch,
which would be rather odd.

I'll make sure the branches merge fine and then apply your patch 2/2
on top of the merge, ok?

	Arnd
