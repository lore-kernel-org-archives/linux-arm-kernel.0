From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 15:09:54 +0200
Subject: [PATCHv2 3/5] clk: samsung: exynos5410: Add suspend/resume
 handling
In-Reply-To: <1406805732-17372-4-git-send-email-hsnaves@gmail.com>
References: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
 <1406805732-17372-4-git-send-email-hsnaves@gmail.com>
Message-ID: <53DA4022.3040906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Humberto,

On 31.07.2014 13:22, Humberto Silva Naves wrote:
> This patch implements all the necessary code that handles register
> saving and restoring during a suspend/resume cycle. To make this
> possible, the local variable reg_base from the function
> exynos5410_clk_init was changed to global. In addition, new
> clock register definitions were added for the majority of the relevant
> clocks inside the SoC.
> 
> Signed-off-by: Humberto Silva Naves <hsnaves@gmail.com>
> ---
>  drivers/clk/samsung/clk-exynos5410.c |  231 +++++++++++++++++++++++++++++++++-
>  1 file changed, 228 insertions(+), 3 deletions(-)

Looks good, thanks. Since this patch depends on previous ones from this
series, I'll wait for next revision (+some time to let people see the
patches) before applying.

Best regards,
Tomasz
