From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 15:49:17 +0100
Subject: [PATCH v5 2/5] clk/samsung: add support for pll2550xx
In-Reply-To: <1394636208-3125-3-git-send-email-rahul.sharma@samsung.com>
References: <1394636208-3125-1-git-send-email-rahul.sharma@samsung.com>
 <1394636208-3125-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <5321C56D.90002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 12.03.2014 15:56, Rahul Sharma wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> exynos5260 use pll2550xx and it has different bit fields
> for P,M,S values as compared to pll2550. Support for
> pll2550xx is added here.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> ---
>   drivers/clk/samsung/clk-pll.c |  108 +++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/samsung/clk-pll.h |    1 +
>   2 files changed, 109 insertions(+)

Applied, thanks.

Best regards,
Tomasz
