From: davidb@codeaurora.org (David Brown)
Date: Thu, 13 Sep 2012 09:15:48 -0700
Subject: [PATCH 1/2] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <201209130847.20087.arnd@arndb.de>
References: <1347461906-13527-7-git-send-email-arnd@arndb.de>
 <1347490900-8409-1-git-send-email-davidb@codeaurora.org>
 <201209130847.20087.arnd@arndb.de>
Message-ID: <20120913161548.GA11395@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 08:47:19AM +0000, Arnd Bergmann wrote:
> On Wednesday 12 September 2012, David Brown wrote:
> > 
> > From: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Convert MSM SMP platforms to use the SoC descriptor to provide
> > their SMP and CPU hotplug operations.
> > 
> > Cc: David Brown <davidb@codeaurora.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > This is an adaptation of this change on top of the msm-for-3.7 tree I
> > recently sent out a pull request for.  The only real change is to
> > resolve the conflicts with the simplified board files.
> 
> Not sure what I'm supposed to do with this patch, it doesn't apply
> unless I rebase all of the SMP patches on top of your msm-for-3.7 branch,
> which would be rather odd.
> 
> I'll make sure the branches merge fine and then apply your patch 2/2
> on top of the merge, ok?

Yeah, it shouldn't hurt anything to just wait until both get merged
in.  The patch was mostly a heads up that your series was going to
conflict with msm changes coming in.

Olof wanted me to try and split the msm-for-3.7 into a few branches,
so I'm going to work on that this morning.  I'm not quite sure how
well it will work, since, for example, most of the cleanups are
preparing the tree for the devicetree changes.

David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
