From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 09:28:36 -0600
Subject: [PATCH 1/2] ARM: tegra: dt: add L2 cache controller
In-Reply-To: <1351477701.2779.70.camel@jlo-ubuntu-64.nvidia.com>
References: <1351247649-15859-1-git-send-email-josephl@nvidia.com>
 <508AC294.7080506@wwwdotorg.org>
 <1351477701.2779.70.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <508EA0A4.6000105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 08:28 PM, Joseph Lo wrote:
> On Sat, 2012-10-27 at 01:04 +0800, Stephen Warren wrote:
>> On 10/26/2012 04:34 AM, Joseph Lo wrote:
>>> Add L2 cache controller binding into DT for Tegra.
...
>> Finally, is this series going to be a dependency for any of the cpuidle
>> or other work you're submitting? I assume it's completely independent
>> and hence I can throw it in any old branch in any order I feel like?
> 
> No. We need this before the "powered-down" cpuidle support. Because the
> L2 init function didn't help to hook the resume API to "outer_cache_fns"
> interface currently. If we don't apply this before the "powered-down"
> cpuidle, we will lost L2 support after one successful powered-down
> cpuidle sequence.

OK, please do mention dependencies like this when posting the patches.
Thanks.
