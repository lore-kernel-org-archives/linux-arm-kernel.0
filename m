From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Feb 2013 07:24:56 -0800
Subject: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from the
 driver
In-Reply-To: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Wed, 20 Feb 2013 15:30:44 +0530")
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87sj4rqa7r.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
> so remove the hackery from the driver.
>
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> ---
>  drivers/tty/serial/omap-serial.c |   23 -----------------------
>  1 file changed, 23 deletions(-)

This patch should also remove the hooks from
<linux/platform_data/serial-omap.h>

Kevin
