From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 01 May 2014 12:45:56 +0530
Subject: [PATCH v3 01/16] clk: exynos5420: rename parent clocks
In-Reply-To: <1398344632-18623-2-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
 <1398344632-18623-2-git-send-email-shaik.ameer@samsung.com>
Message-ID: <5361F4AC.2060106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 06:33 PM, Shaik Ameer Basha wrote:
> This patch modifies the defined parent clock names as per the
> exynos5420 datasheet.
> 
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c |  359 ++++++++++++++++++----------------
>  1 file changed, 187 insertions(+), 172 deletions(-)
>  mode change 100644 => 100755 drivers/clk/samsung/clk-exynos5420.c
> 

File mode should not be changed.

-- 
Tushar Behera
