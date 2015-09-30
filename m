From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Sep 2015 10:08:18 +0800
Subject: [PATCH v2 1/2] ARM: imx6: set ahb-burst-config as 0 for USB
In-Reply-To: <1442901601-13738-1-git-send-email-peter.chen@freescale.com>
References: <1442901601-13738-1-git-send-email-peter.chen@freescale.com>
Message-ID: <CAAQ0ZWSHLKhmor8kUZ10PWMUojM8SieeHBKOhBmkppYvX6nGkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 2:00 PM, Peter Chen <peter.chen@freescale.com> wrote:
> After setting ahb burst configuration as 0, we can increase tx/rx
> burst size, it will improve the USB performance
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

I have been stopped using my Linaro mailbox for patch collecting.
Please resend to Shawn Guo <shawnguo@kernel.org>, which is documented
in MAINTAINTERS.

Shawn
