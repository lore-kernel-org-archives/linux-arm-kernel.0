From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 7 Mar 2012 09:50:34 +0000
Subject: [PATCH 0/3] ARM: OMAP1/2+: 32k-timer: Add hwmod lookup for
 32k-timer
In-Reply-To: <20120305225751.GL12083@atomide.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A8317AF2D2@DBDE01.ent.ti.com>
 <20120305225751.GL12083@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83180A03F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 04:27:52, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120123 00:16]:
> > On Thu, Jan 19, 2012 at 19:58:21, Hiremath, Vaibhav wrote:
> > > This patch series cleans up the existing 32k-sync timer implementation
> > > without any major code change and adds hwmod lookup for omap2+ devices,
> > > if lookup fails then fall back to gp-timer.
> ...
>  
> > Tony,
> > 
> > If there are no review comments, can this be merged?
> 
> Made a minor comment on the first patch, it would be nice to get
> that clean-up merged. The other two depend on some some hwmod
> data shrinkage by Paul..
> 

Working on it, will be submitting next version soon.

Thanks,
Vaibhav

> Regards,
> 
> Tony
> 
