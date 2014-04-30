From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 30 Apr 2014 21:11:47 +0530
Subject: [PATCH v3 08/16] clk: exynos5420: update clocks for PERIS and GEN
 blocks
In-Reply-To: <1398344632-18623-9-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
 <1398344632-18623-9-git-send-email-shaik.ameer@samsung.com>
Message-ID: <CAK9yfHx4AsW9_wgkoY+7NnY6iHMURSc=hS3_g+tSfWZgWUA8oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On 24 April 2014 18:33, Shaik Ameer Basha <shaik.ameer@samsung.com> wrote:
> This patch fixes some parent-child relationships according
> to the latest datasheet and adds more clocks related to
> PERIS and GEN blocks.

Again, it is better to split up the fixes from other stuff so that it
can go in the -rc
and can be back ported to stable if needed.

-- 
With warm regards,
Sachin
