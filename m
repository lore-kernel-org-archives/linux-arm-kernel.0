From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 10 Jun 2015 10:39:22 +0200
Subject: [RFT v2 34/48] pinctrl: Prepare for killing the first parameter
 'irq' of irq_flow_handler_t
In-Reply-To: <1433391238-19471-35-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-35-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <4497677.ZpyibMJVfv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. Juni 2015, 12:13:44 schrieb Jiang Liu:
> Change irq flow handler to prepare for killing the first parameter 'irq'
> of irq_flow_handler_t.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c    |    4 ++--

For Rockchip
Acked-by: Heiko Stuebner <heiko@sntech.de>
