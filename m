From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 29 Jul 2014 12:07:11 +0200
Subject: [PATCH v8 1/6] clk: samsung: add infrastructure to register cpu
 clocks
In-Reply-To: <1406611711-25112-2-git-send-email-thomas.ab@samsung.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
 <1406611711-25112-2-git-send-email-thomas.ab@samsung.com>
Message-ID: <53D7724F.8040402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 29.07.2014 07:28, Thomas Abraham wrote:
> The CPU clock provider supplies the clock to the CPU clock domain. The
> composition and organization of the CPU clock provider could vary among
> Exynos SoCs. A CPU clock provider can be composed of clock mux, dividers
> and gates. This patch defines a new clock type for CPU clock provider and
> adds infrastructure to register the CPU clock providers for Samsung
> platforms.
> 
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/clk/samsung/Makefile  |    2 +-
>  drivers/clk/samsung/clk-cpu.c |  335 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-cpu.h |   91 +++++++++++
>  3 files changed, 427 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/samsung/clk-cpu.c
>  create mode 100644 drivers/clk/samsung/clk-cpu.h
> 

Thanks for keeping up with review comments.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
