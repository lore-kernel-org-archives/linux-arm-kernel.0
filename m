From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 22 Jul 2013 15:33:54 +0530
Subject: [PATCH v3 4/5] ARM: davinci: da8xx: remove da8xx_uart_clk_enable
In-Reply-To: <1371633342-1210-5-git-send-email-prakash.pm@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
 <1371633342-1210-5-git-send-email-prakash.pm@ti.com>
Message-ID: <51ED038A.6000009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013 02:45 PM, Manjunathappa, Prakash wrote:
> Serial clocks are enabled from of_platform_serial_setup:of_serial.c,
> so remove davinci_serial_setup_clk from here.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Adding to v3.12/soc branch.

Thanks,
Sekhar
