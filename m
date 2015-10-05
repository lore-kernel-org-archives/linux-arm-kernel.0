From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Oct 2015 17:59:10 +0200
Subject: [PATCH v7 2/3] pwm: add MediaTek display PWM driver support
In-Reply-To: <1439882875-19596-3-git-send-email-yh.huang@mediatek.com>
References: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
 <1439882875-19596-3-git-send-email-yh.huang@mediatek.com>
Message-ID: <20151005155910.GE17612@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 03:27:54PM +0800, YH Huang wrote:
> Add display PWM driver support to modify backlight for MT8173 and MT6595.
> The PWM has one channel to control the brightness of the display.
> When the (high_width / period) is closer to 1, the screen is brighter;
> otherwise, it is darker.
> 
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/pwm/Kconfig        |   11 +++
>  drivers/pwm/Makefile       |    1 +
>  drivers/pwm/pwm-mtk-disp.c |  232 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 244 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/c61d9679/attachment.sig>
