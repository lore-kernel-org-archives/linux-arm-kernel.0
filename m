From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 30 May 2016 14:50:32 +0200
Subject: [PATCH] clk: samsung: exynos7: Don't gate CMU_{CCORE,
 FSYS0} blocks clock
In-Reply-To: <1460608972-13878-1-git-send-email-alim.akhtar@samsung.com>
References: <1460608972-13878-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <574C3718.3050301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2016 06:42 AM, Alim Akhtar wrote:
> This patch adds CLK_IS_CRITICAL flag to ACLK_CCORE_133 and ACLK_FSYS0_200
> clocks. These clocks are critical for accessing CMU_CCORE and CMU_FSYS0
> blocks registers. Let these clocks to be enabled all the time.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Patch applied, thanks.
