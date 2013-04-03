From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:23:59 +0800
Subject: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
In-Reply-To: <515C101F.1020801@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
 <5155BB27.4000405@wwwdotorg.org>  <515C101F.1020801@linaro.org>
Message-ID: <1364988239.16957.78.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-03 at 19:18 +0800, Daniel Lezcano wrote:
> On 03/29/2013 05:02 PM, Stephen Warren wrote:
> > On 03/29/2013 04:31 AM, Daniel Lezcano wrote:
> >> Initialize the idle states directly in the driver structure.
> >>
> >> That prevents extra structure declaration and memcpy at init time.
> > 
> > Joseph, can you please review/ack patch 5/9 and patch 6/9. Thanks.
> 
> Thanks Joseph to review the patches.
> 
> Rafael is expecting an Acked-by.
> 
> If you are ok, with these patches, is it possible to ack them please ?
> 
OK.

The 5/9 and 6/9 of this series.
Acked-by: Joseph Lo <josephl@nvidia.com>

Thanks,
Joseph
> 
> 
