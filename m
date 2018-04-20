From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 20 Apr 2018 09:23:41 +0200
Subject: [PATCH 53/61] tty: serial: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
Message-ID: <ce3c4fa9-c6bc-a529-3c91-9f353d017720@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/tty/serial/imx.c              | 18 ++++++------------
>  drivers/tty/serial/qcom_geni_serial.c |  6 ++----
>  drivers/tty/serial/st-asc.c           |  6 ++----
>  drivers/tty/serial/xilinx_uartps.c    |  6 ++----

Acked-by: Michal Simek <michal.simek@xilinx.com> (for xilinx)

Thanks,
Michal
