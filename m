From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 6 Apr 2013 17:21:37 -0300
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Feb 22, 2013 at 8:51 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Changes since v1:
>  * Remove the absolute path of imxXX-pinfunc.h in binding doc
>  * Remove the pin id from PIN_FUNC_ID/macro
>
> Shawn Guo (3):
>   ARM: dts: imx: use pre-processor for device trees
>   ARM: dts: imx: replace magic number with pin function name
>   pinctrl: imx: move hard-coding data into device tree

The last patch breaks audio on mx6qsabrelite: after a aplay command
the processor hangs.
