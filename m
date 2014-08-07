From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 7 Aug 2014 14:55:51 +0200
Subject: [PATCH v2] pwm: imx: set can_sleep flag for imx_pwm
In-Reply-To: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
References: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140807125549.GA32027@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 04:41:28PM +0800, Shawn Guo wrote:
> The .config() hook imx_pwm_config() calls clk APIs like clk_prepare()
> and clk_get_rate(), which might sleep, so we need to set can_sleep flag
> on pwm_chip.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes since v1:
>  - Set can_sleep flag for both imx_pwm_v1 and imx_pwm_v2
> 
>  drivers/pwm/pwm-imx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/4e5cbc13/attachment.sig>
