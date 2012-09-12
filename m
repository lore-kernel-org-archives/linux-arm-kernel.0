From: davidb@codeaurora.org (David Brown)
Date: Wed, 12 Sep 2012 09:26:52 -0700
Subject: [PATCH v9 06/13] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <1347461906-13527-7-git-send-email-arnd@arndb.de>
References: <1347461906-13527-1-git-send-email-arnd@arndb.de>
 <1347461906-13527-7-git-send-email-arnd@arndb.de>
Message-ID: <20120912162651.GA22904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 04:58:19PM +0200, Arnd Bergmann wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Convert MSM SMP platforms to use the SoC descriptor to provide
> their SMP and CPU hotplug operations.
> 
> Cc: David Brown <davidb@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-msm/board-msm8960.c |    3 +++
>  arch/arm/mach-msm/board-msm8x60.c |    7 +++++++

Stephen Boyd recently sent out a patch series that remove the non-DT
support for these two targets, which naturally generates a bunch of
conflicts.

I'm about to send out a pull request including these changes, and
after that, I'll rework this patch for the new board files, and give
it a try.

David Brown

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
