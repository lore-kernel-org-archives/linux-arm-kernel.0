From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 07 Nov 2013 04:11:49 -0600
Subject: [GIT PULL] clk: socfpga: Clock fix for 3.13
In-Reply-To: <1382604095-3097-1-git-send-email-dinguyen@altera.com>
References: <1382604095-3097-1-git-send-email-dinguyen@altera.com>
Message-ID: <527B6765.1000409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 10/24/13 3:41 AM, dinguyen at altera.com wrote:
> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
>
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
>
> are available in the git repository at:
>
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.13
>
> for you to fetch changes up to f592c5da6869133de941e44ef2ed4ede7f6b2791:
>
>   clk: socfpga: Remove check for "reg" property in socfpga_clk_init (2013-10-24 03:18:30 -0500)
>
> ----------------------------------------------------------------
> Clock fix for SOCFPGA
>
> Remove check for "reg" property in socfpga_clk_init() function
> This allows for clk property to be assigned for the arm_twd timer, which
> will lead to removing socfpga_init_clocks().
>
> ----------------------------------------------------------------
> Dinh Nguyen (1):
>       clk: socfpga: Remove check for "reg" property in socfpga_clk_init
>
>  drivers/clk/socfpga/clk.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
Can you please pull this?
Thanks,
Dinh
