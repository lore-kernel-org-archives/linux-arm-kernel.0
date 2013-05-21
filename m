From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 21 May 2013 18:16:21 +1200
Subject: [PATCH] i2c: vt8500: Add support for I2C bus on Wondermedia SoCs
In-Reply-To: <1368350634-12654-1-git-send-email-linux@prisktech.co.nz>
References: <1368350634-12654-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <519B1135.4060509@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/13 21:23, Tony Prisk wrote:
> This patch adds support for the I2C bus controllers found on Wondermedia
> 8xxx-series SoCs. Only master-mode is supported.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>   .../devicetree/bindings/i2c/i2c-vt8500.txt         |   24 +
>   MAINTAINERS                                        |    1 +
>   drivers/i2c/busses/Kconfig                         |   10 +
>   drivers/i2c/busses/Makefile                        |    1 +
>   drivers/i2c/busses/i2c-wmt.c                       |  488 ++++++++++++++++++++
>   5 files changed, 524 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-vt8500.txt
>   create mode 100644 drivers/i2c/busses/i2c-wmt.c
>
>
This patch seems to have stalled. Any news?

Regards
Tony Prisk
