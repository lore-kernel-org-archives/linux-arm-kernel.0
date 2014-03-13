From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 15:33:23 +0100
Subject: [PATCH v2 1/3] clk: s2mps11: Add support for S2MPS14 clocks
In-Reply-To: <1394703425-6462-2-git-send-email-k.kozlowski@samsung.com>
References: <1394703425-6462-1-git-send-email-k.kozlowski@samsung.com>
 <1394703425-6462-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5321C1B3.2050806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 13.03.2014 10:37, Krzysztof Kozlowski wrote:
> This patch adds support for S2MPS14 PMIC clocks (BT and AP) to the
> s2mps11 clock driver.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>   drivers/clk/Kconfig       |    8 +++---
>   drivers/clk/clk-s2mps11.c |   61 ++++++++++++++++++++++++++++++++++-----------
>   2 files changed, 50 insertions(+), 19 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
