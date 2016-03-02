From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 Mar 2016 12:46:45 +0900
Subject: [PATCH] arm64: defconfig: Enable devices for Hi6220 and 96boards
 HiKey
In-Reply-To: <1456815648-10935-1-git-send-email-guodong.xu@linaro.org>
References: <1456815648-10935-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <20160302034645.GA24414@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 01, 2016 at 03:00:48PM +0800, Guodong Xu wrote:
> This patch enables a number of devices currently supported by the Hi6220
> and 96boards HiKey. These include
> a) Hi655x PMIC and regulator
> b) Hi6220 I2C, USB, MMC, mailbox, reset
> c) CONFIG_PINCTRL_SINGLE, and CONFIG_LEDS_GPIO
> 
> CONFIG_MMC_BLOCK_MINORS is set to 16 (default is 8).
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

In general updates to the above file go through platform maintainer's trees.
I was unable to work out who the Hi6220 and 96boards HiKey maintainers are,
but you should probably send this patch to them.
