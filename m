From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 21 Sep 2013 19:31:04 -0700
Subject: [PATCH v5] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <1379806839-13762-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1379806839-13762-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <523E5668.2000201@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2013 04:40 PM, Soren Brinkmann wrote:
> Add a driver for SILabs 570, 571, 598, 599 programmable oscillators.
> The devices generate low-jitter clock signals and are reprogrammable via
> an I2C interface.
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Looks good to me. Thanks a lot for picking this up.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
