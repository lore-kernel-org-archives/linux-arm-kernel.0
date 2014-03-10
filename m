From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 10 Mar 2014 01:29:36 +0100
Subject: [PATCH v4 3/5] clk/samsung: add support for pll2650xx
In-Reply-To: <1393931558-23502-4-git-send-email-rahul.sharma@samsung.com>
References: <1393931558-23502-1-git-send-email-rahul.sharma@samsung.com>
 <1393931558-23502-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <531D0770.1050201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.03.2014 12:12, Rahul Sharma wrote:
> Add support for pll2650xx in samsung pll file. This pll variant
> is close to pll36xx but uses CON2 registers instead of CON1.
>
> Aud_pll in Exynos5260 is pll2650xx and uses this code.
>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
>   drivers/clk/samsung/clk-pll.c |  101 +++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/samsung/clk-pll.h |    1 +
>   2 files changed, 102 insertions(+)

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
