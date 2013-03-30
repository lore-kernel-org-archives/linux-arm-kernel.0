From: josephl@nvidia.com (Joseph Lo)
Date: Sat, 30 Mar 2013 10:22:32 +0800
Subject: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
In-Reply-To: <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364610152.2622.3.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-29 at 18:31 +0800, Daniel Lezcano wrote:
> Initialize the idle states directly in the driver structure.
> 
> That prevents extra structure declaration and memcpy at init time.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

Thank you.

Both the 5th and 6th patch,

Reviewed-by: Joseph Lo <josephl@nvidia.com>
