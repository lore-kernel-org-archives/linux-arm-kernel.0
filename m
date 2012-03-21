From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 21 Mar 2012 15:20:20 +0530
Subject: [RFC][PATCH 2/7] ARM: OMAP4: cpuidle - Declare the states with
 the driver declaration
In-Reply-To: <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F69A45C.5050802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Jean,

On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
> The cpuidle API allows to declare statically the states in the driver
> structure. Let's use it.
> We do no longer need the fill_cstate function called at runtime and
> by the way adding more instructions at boot time.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Jean added the fill_cstate() kind of helpers o.w in the old
cpuidle code9OMAP30, static tables were used. Ofcourse those
tables were not uinsg the cpuidle driver structure.

Regards
santosh
