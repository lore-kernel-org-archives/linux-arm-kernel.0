From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 21 Mar 2012 18:05:54 +0000
Subject: [PATCH] ARM: davinci: Fix for cpuidle consolidation changes
In-Reply-To: <1332348505-28780-1-git-send-email-rob.lee@linaro.org>
References: <1332348505-28780-1-git-send-email-rob.lee@linaro.org>
Message-ID: <DF0F476B391FA8409C78302C7BA518B631800C76@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 22:18:25, Robert Lee wrote:
> The recent cpuidle consolidation changes erroneously omitted one
> critical line of code.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>

Tested this on a DA850 EVM.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
