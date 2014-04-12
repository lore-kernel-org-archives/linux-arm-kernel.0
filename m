From: tony@atomide.com (Tony Lindgren)
Date: Sat, 12 Apr 2014 07:52:51 -0700
Subject: [PATCH 00/55]: ARM: OMAP2+: PRCM move to drivers
In-Reply-To: <534913AC.8060402@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
 <20140331220903.GA11328@atomide.com> <533A7A23.8020606@ti.com>
 <20140401171325.GA28041@atomide.com> <534913AC.8060402@ti.com>
Message-ID: <20140412145251.GA32292@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140412 03:25]:
> 
> Just letting you know, that I created a kind of v2 for this set,
> however I am not going to post it publicly before the pre-reqs for
> this set are covered, basically the OMAP2 clock DT set. CM/PRM
> cleanup set is outdated with this series though (I'll post a note on
> it separately) and its contents are merged to this latest re-work.
> 
> The latest wip branch is available publicly if someone is interested:
> 
> https://github.com/t-kristo/linux-pm/tree/3.14-rc4-cm-prm-driver-wip
> 
> I also added Tony's vc fixes set to this branch and removed the
> direct prm register accesses added there.

Well let's merge the fixes first. Sounds like the prm register access
changes for the vc can be merged already so care to post those
changes against v3.14 or v3.15-rc1 separately?

Regards,

Tony
