From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Mar 2015 19:45:17 +0800
Subject: [PATCH] pinctrl: imx: do not implicitly set pin regs to -1
In-Reply-To: <1423240256-27210-1-git-send-email-stefan@agner.ch>
References: <1423240256-27210-1-git-send-email-stefan@agner.ch>
Message-ID: <20150302114516.GC3040@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 05:30:56PM +0100, Stefan Agner wrote:
> Commit 3dac1918a491 ("pinctrl: imx: detect uninitialized pins") needs
> the values in struct imx_pin_reg to be -1. This has been done in a
> rather unorthodox way by setting the memory to 0xff using memset...
> Use a proper for loop to initialize the whole array with -1.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
