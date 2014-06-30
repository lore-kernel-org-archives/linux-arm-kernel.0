From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 19:58:58 +0200
Subject: [PATCH v5 3/3] clk: samsung: exynos5420: Setup clocks before
 system suspend
In-Reply-To: <1403781135-6538-4-git-send-email-vikas.sajjan@samsung.com>
References: <1403781135-6538-1-git-send-email-vikas.sajjan@samsung.com>
 <1403781135-6538-4-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <53B1A562.6000300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas, Abhilash,

On 26.06.2014 13:12, Vikas Sajjan wrote:
> Prior to suspending the system, we need to ensure that certain
> clock source and gate registers are unmasked.
> 
> while at it, add these clks to save/restore list also.
> 
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Looks good. Will apply.

Best regards,
Tomasz
