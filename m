From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 5 Aug 2012 14:08:07 -0300
Subject: [PATCH] clk: mxs: Register USB clocks for mx23
In-Reply-To: <20120620143830.GF2253@S2101-09.ap.freescale.net>
References: <1340148392-9847-1-git-send-email-festevam@gmail.com>
 <20120620143830.GF2253@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5AaLKN9bhuPRLJkA8ytiwVi_yrpwzL0mJAzf6VS4PSRLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 11:38 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
...
>> +     clk_register_clkdev(clks[usb_pwr], NULL, "8007c000.usbphy");
>> +     clk_register_clkdev(clks[usb], NULL, "80080000.usb");
>
> It depends on the node name in device tree.  I would defer this
> a little bit to have the node name in dts settled down first.

Now that the mxs usb driver is in mainline, could this patch be applied?

Regards,

Fabio Estevam
