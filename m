From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 27 Mar 2014 11:55:47 +0100
Subject: [PATCH] clk: register fixed-clock only if #clock-cells property is
 present
In-Reply-To: <1395858127-18730-1-git-send-email-s.nawrocki@samsung.com>
References: <1395858127-18730-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <533403B3.6070602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, please ignore this patch for now. It turns out a less intrusive
change [1] is enough to fix the regressions on both imx and exynos.

I'm going to address the issue properly for next kernel release and
make exynos use regular fixed-clock driver, rather than registering
the external clock generators within the SoC main clock controller
driver.

-- 
Thanks,
Sylwester

[1] http://permalink.gmane.org/gmane.linux.kernel/1673639
