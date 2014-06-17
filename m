From: tj@kernel.org (Tejun Heo)
Date: Tue, 17 Jun 2014 12:32:42 -0400
Subject: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <53A06B65.7030407@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
 <1470404.13mIFv0Hnj@amdc1032> <53A0686F.4000303@wwwdotorg.org>
 <20140617161320.GG31819@htj.dyndns.org>
 <20140617161447.GH31819@htj.dyndns.org>
 <53A06B65.7030407@wwwdotorg.org>
Message-ID: <20140617163242.GK31819@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:23:01AM -0600, Stephen Warren wrote:
> > Please also drop inline.  It isn't a difficult optimization to perform
> > for the compiler.
> 
> There are probably hundreds of drivers marking those functions inline.

We used to need them.  We no longer do.  We're in a very long
transition phase.

> If they aren't marked inline, it'll just stick out as unusual when
> people read them all, and then they'll send patches to fix it.

Don't worry.  They won't be applied.

Thanks.

-- 
tejun
