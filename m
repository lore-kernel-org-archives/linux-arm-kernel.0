From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 13:03:50 +0200
Subject: [PATCH v5 02/46] backlight: pwm_bl: remove useless call to
 pwm_set_period()
In-Reply-To: <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160412110350.GH18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:03:25PM +0200, Boris Brezillon wrote:
> The PWM period will be set when calling pwm_config. Remove this useless
> call to pwm_set_period(), which might mess up with the internal PWM state.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/3b260a14/attachment.sig>
