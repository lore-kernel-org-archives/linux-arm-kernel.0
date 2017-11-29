From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 29 Nov 2017 10:59:52 +0000
Subject: [PATCH] mfd: ab8500-debugfs: Use common error handling code in
 ab8500_print_modem_registers()
In-Reply-To: <7af3098c-21fd-aa16-237f-0359d312cac7@users.sourceforge.net>
References: <7af3098c-21fd-aa16-237f-0359d312cac7@users.sourceforge.net>
Message-ID: <20171129105952.pf6lywfqfsnmcnni@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Oct 2017, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 27 Oct 2017 17:20:45 +0200
> 
> Add jump targets so that two error messages are stored only once
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/ab8500-debugfs.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
