From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 16 Apr 2013 14:00:41 +0530
Subject: [V3 patch 18/19] ARM: davinci: cpuidle: use init/exit common
 routine
In-Reply-To: <1365770165-27096-19-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-19-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <516D0C31.2010403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2013 6:06 PM, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Tested on DA850 EVM.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
