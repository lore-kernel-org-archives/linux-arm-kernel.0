From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Oct 2012 07:24:16 +0000
Subject: [PATCH v4 0/5] zynq subarch cleanups
In-Reply-To: <cover.1351466765.git.josh.cartwright@ni.com>
References: <cover.1351466765.git.josh.cartwright@ni.com>
Message-ID: <5c2911d7-f753-4d9f-b8d8-3bf011d58e52@TX2EHSMHS014.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

 Michal-
> 
> Here is a v5 of the zynq cleanup patchset that addresses your feedback.  I've
> intentionally left patches 4 and 5 in the set until we figure out the appropriate
> way to get them in tree (feel free to just apply 1-3)

I am ok to pick just several patches from your patchset. But this is no definitely 
good working style. Not expert for submission process but I think that 
if there is one broken patch maintainer shouldn't apply it.
Can someone else check this?


> I've also moved the uart mapping in patch 5 to a known working address, until
> we can work out what is happening there.  This should allow this patchset to be
> applied and have the zc702 boot.

Will look at it and apply if works.
 
> You had suggested removing/renaming the zynq-ep107.dts; it wasn't clear
> whether you had wanted that in this patchset or not.  I'm going to assume not.
> I'll follow up with this, after this patchset is applied, if that works for you.

Not in this patchset. Sure feel free to send it.  

Thanks,
Michal
