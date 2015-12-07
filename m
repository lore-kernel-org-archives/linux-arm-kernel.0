From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 18:43:55 +0100
Subject: [PATCH v2 2/3] clk: add Dove PLL divider support for GPU,
 VMeta and AXI clocks
In-Reply-To: <E1a5ijI-0007pk-0I@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Sun, 06 Dec 2015 23:28:32 +0000")
References: <E1a5ijI-0007pk-0I@rmk-PC.arm.linux.org.uk>
Message-ID: <87d1uib1d0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike and Stephen,
 
 On lun., d?c. 07 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Add support for the Dove PLL dividers, which are used to generate the
> clocks for the AXI bus, as well as the GPU and VMeta peripherals.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/clk/mvebu/Makefile       |   2 +-
>  drivers/clk/mvebu/dove-divider.c | 262 +++++++++++++++++++++++++++++++++++++++
>  drivers/clk/mvebu/dove.c         |   6 +
>  3 files changed, 269 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mvebu/dove-divider.c

Do you plan to apply this patch directly or do you expect a pull request
from mvebu for it (of course once you will have give your Acked-by)?

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
