From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 10 Sep 2014 14:26:04 +0800
Subject: [PATCH 0/6] ARM: dts: imx: ventana: dt cleanups
In-Reply-To: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
References: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20140910062602.GB22579@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 11:07:25PM -0700, Tim Harvey wrote:
> This series contains several clean-ups for the Gateworks Ventana boards
> already in mainline largely based on conventions that have become standard
> since the patches were originally committed. The final patch also adds
> additional support for GW52xx CANbus that was not there previously but
> depends on the prior patches.
> 
> Tim Harvey (6):
>   ARM: dts: imx: ventana: remove unsupported dt nodes
>   ARM: dts: imx: ventana: remove unused aliases
>   ARM: dts: imx: ventana: use gpio constants
>   ARM: dts: imx: ventana: configure padconf for all pins
>   ARM: dts: imx: ventana: cleanup pinctrl groups
>   ARM: dts: imx: ventana: add canbus support for GW52xx

Applied all, thanks.
