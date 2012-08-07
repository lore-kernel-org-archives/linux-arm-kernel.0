From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 07 Aug 2012 16:57:51 +0530
Subject: [PATCH 0/4] i2c: omap: few more patches
In-Reply-To: <1344262737-6662-1-git-send-email-balbi@ti.com>
References: <1344262737-6662-1-git-send-email-balbi@ti.com>
Message-ID: <5020FBB7.3030308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012 07:48 PM, Felipe Balbi wrote:
> Just a few extra patches on top of the earlier series I sent.
>
> With these patches, we have threaded irq support and autosuspend support for
> i2c-omap driver.
Thanks for the patches.
>
> All patches boot tested with pandaboard.
Tested-by: Shubhrajyoti <shubhrajyoti@ti.com>

On omap4sdp and omap3sdp
also on omap3 did some basic power testing.
> Felipe Balbi (4):
>   i2c: omap: always return IRQ_HANDLED
>   i2c: omap: switch to threaded IRQ support
>   i2c: omap: remove unnecessary pm_runtime_suspended check
>   i2c: omap: switch over to autosuspend API
>
>  drivers/i2c/busses/i2c-omap.c | 53 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
>
