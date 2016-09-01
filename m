From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 01 Sep 2016 19:07:30 +0200
Subject: [PATCH 2/2] clk: samsung: exynos5410: Use
 samsung_cmu_register_one() to simplify code
In-Reply-To: <1471834185-20249-3-git-send-email-cw00.choi@samsung.com>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
 <1471834185-20249-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <cf7b4b6f-f156-3460-761c-2268203c7593@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 04:49 AM, Chanwoo Choi wrote:
> This patch uses the samsung_cmu_register_one() to simplify code
> and move the pll/mux/div/gate data to initconst section.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Applied, thanks.
