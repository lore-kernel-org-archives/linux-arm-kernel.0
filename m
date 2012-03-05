From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 14:57:52 -0800
Subject: [PATCH 0/3] ARM: OMAP1/2+: 32k-timer: Add hwmod lookup for
 32k-timer
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317AF2D2@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A8317AF2D2@DBDE01.ent.ti.com>
Message-ID: <20120305225751.GL12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120123 00:16]:
> On Thu, Jan 19, 2012 at 19:58:21, Hiremath, Vaibhav wrote:
> > This patch series cleans up the existing 32k-sync timer implementation
> > without any major code change and adds hwmod lookup for omap2+ devices,
> > if lookup fails then fall back to gp-timer.
...
 
> Tony,
> 
> If there are no review comments, can this be merged?

Made a minor comment on the first patch, it would be nice to get
that clean-up merged. The other two depend on some some hwmod
data shrinkage by Paul..

Regards,

Tony
