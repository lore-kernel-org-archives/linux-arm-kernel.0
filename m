From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 23 Jan 2014 19:19:11 +0100
Subject: [PATCH V2 01/10] clk/exynos5410: move suspend/resume handling to
 SoC driver
In-Reply-To: <1389099548-14649-2-git-send-email-rahul.sharma@samsung.com>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
 <1389099548-14649-2-git-send-email-rahul.sharma@samsung.com>
Message-ID: <52E15D1F.8090802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.01.2014 13:58, Rahul Sharma wrote:
> Suspend/resume handling is already moved for all other Exynos
> SoCs other than Exynos5420 which is addressed in this patch.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5410.c |   49 ++++++++++++++++++++++++++++++----
>   1 file changed, 44 insertions(+), 5 deletions(-)

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
