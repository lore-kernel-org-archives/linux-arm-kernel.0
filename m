From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 09:39:40 +0200
Subject: [PATCH 3/4] drivers/pwm: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <1381681071-6021-4-git-send-email-wsa@the-dreams.de>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-4-git-send-email-wsa@the-dreams.de>
Message-ID: <20131022073939.GD8681@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 06:17:49PM +0200, Wolfram Sang wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for setting the default pins. Compile tested only.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/pwm/pwm-tiecap.c   | 6 ------
>  drivers/pwm/pwm-tiehrpwm.c | 6 ------
>  2 files changed, 12 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/8d23fbef/attachment.sig>
