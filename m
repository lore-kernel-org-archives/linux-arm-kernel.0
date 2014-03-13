From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 15:50:13 +0100
Subject: [PATCH v5 3/5] clk/samsung: add support for pll2650xx
In-Reply-To: <1394636208-3125-4-git-send-email-rahul.sharma@samsung.com>
References: <1394636208-3125-1-git-send-email-rahul.sharma@samsung.com>
 <1394636208-3125-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <5321C5A5.9040808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 12.03.2014 15:56, Rahul Sharma wrote:
> Add support for pll2650xx in samsung pll file. This PLL variant
> is close to pll36xx but uses CON2 registers instead of CON1.
>
> Aud_pll in Exynos5260 is pll2650xx and uses this code.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
>   drivers/clk/samsung/clk-pll.c |  101 +++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/samsung/clk-pll.h |    1 +
>   2 files changed, 102 insertions(+)

Applied with Pankaj's reviewed-by, thanks.

Best regards,
Tomasz
