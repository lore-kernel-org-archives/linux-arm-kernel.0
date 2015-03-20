From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Mar 2015 17:26:40 +0000
Subject: [PATCH 4/6] ARM64: cpuidle: Rename cpu_init_idle to a common
 function name
In-Reply-To: <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20150320172639.GK3421@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 01:29:35PM +0100, Daniel Lezcano wrote:
> With this change the cpuidle-arm64.c file calls the same function name
> for both ARM and ARM64.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

That said, if you find some names to avoid the arm_ prefix it's even
better but either way my ack still stands.
