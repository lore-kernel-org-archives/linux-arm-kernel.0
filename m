From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Jul 2015 17:45:40 +0100
Subject: [PATCH] arm64: cpuidle: add __init section marker to
 arm_cpuidle_init
In-Reply-To: <1435800787-696-1-git-send-email-jszhang@marvell.com>
References: <1435800787-696-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150702164539.GG1354@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 09:33:07AM +0800, Jisheng Zhang wrote:
> It is not needed after booting, this patch moves the arm_cpuidle_init()
> function to the __init section.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied. Thanks.

-- 
Catalin
