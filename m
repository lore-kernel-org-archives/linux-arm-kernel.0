From: tj@kernel.org (Tejun Heo)
Date: Fri, 16 May 2014 13:23:56 -0400
Subject: [PATCH v2 cgroup/for-3.16] cgroup: introduce CSS_NO_REF and skip
 refcnting on normal root csses
In-Reply-To: <5376489C.9010902@wwwdotorg.org>
References: <1399670015-23463-1-git-send-email-tj@kernel.org>
 <1399670015-23463-10-git-send-email-tj@kernel.org>
 <53751062.2050401@wwwdotorg.org> <53753823.2090402@wwwdotorg.org>
 <20140516143718.GA5379@htj.dyndns.org>
 <20140516154330.GB5379@htj.dyndns.org>
 <537643F9.1030303@wwwdotorg.org>
 <20140516170959.GG5379@htj.dyndns.org>
 <5376489C.9010902@wwwdotorg.org>
Message-ID: <20140516172356.GH5379@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 11:19:24AM -0600, Stephen Warren wrote:
> On 05/16/2014 11:09 AM, Tejun Heo wrote:
> > Can you try this one instead?
> 
> Yes, this one works great, thanks.
> Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks, I reverted the original one and applied the updated one w/
your Tested-by tag added.

-- 
tejun
