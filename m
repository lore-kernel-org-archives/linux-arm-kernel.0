From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jun 2012 01:02:48 -0700
Subject: [PATCH] ARM: OMAP2+: am33xx: Add AM335XEVM machine support
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA415E7@DBDE01.ent.ti.com>
References: <1336676929-28621-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA3923D@DBDE01.ent.ti.com>
 <20120605075344.GH12766@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA415E7@DBDE01.ent.ti.com>
Message-ID: <20120605080248.GK12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120605 01:04]:
> On Tue, Jun 05, 2012 at 13:23:44, Tony Lindgren wrote:
> > 
> > Adding this too to devel-am33xx branch.
> > 
> 
> Thanks Tony,
> Also, request you to add it as part of next pull request to the linux-next, 
> at early rc cycle itself.

Yes it should hit arm-soc and linux-next after -rc2 or so.
 
> Paul,
> 
> Can you also send a pull request for AM33XX voltagedomain, cm, clockdomain, 
> prm, powerdomain patches?
> Also request you to review clock-tree and hwmod changes, so that, they can 
> also be merged within time.
> 
> From clocktree perspective, I believe now I have to migrate to Rajendr's 
> common-clock framework changes, so let me finish that and send new version.
> 
> 
> Thanks,
> Vaibhav
