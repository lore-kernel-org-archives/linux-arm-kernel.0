From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Jan 2018 16:56:49 +0000
Subject: [PATCH 00/12] firmware: arm_scpi: series with smaller improvements
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <db85dc34-5755-c48d-8a23-379d95fc0342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiner,

(Sorry for the late response, was off for a month)

On 05/12/17 21:54, Heiner Kallweit wrote:
> After recent revert of all changes since 4.14 this is a resubmit of
> the patch series, reduced to patches which should not cause any
> regression.
> Based on a remark from Kevin I added one patch for improving the
> version info for pre-1.0 firmware that doesn't provide version
> information.
> 
> Best should be to apply it to a devel branch first so that the
> Baylibre Amlogic team can test before mainlining.
> 

I am still waiting for tested by from Amlogic team for this series.
However I prefer even the patch you dropped as causing the issue to
be tested as it's nice cleanup to have. I strongly think that the issue
Kevin reported was due to broken DVFS in the scp firmware in which case
the solution is to have the dvfs node in DT removed or disabled rather
than not having that patch at all.

Please post that patch on rebased on top of this series and get it
tested with DVFS nodes disabled.

-- 
Regards,
Sudeep
