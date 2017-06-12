From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 12 Jun 2017 14:04:23 +0200
Subject: [PATCH] usb: dwc3: exynos: Handle return value of
 clk_prepare_enable
In-Reply-To: <3e8b3037c345341c2bda612b6de204f6c83dde38.1497264433.git.arvind.yadav.cs@gmail.com>
References: <3e8b3037c345341c2bda612b6de204f6c83dde38.1497264433.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170612120423.GB11300@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 04:23:31PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
