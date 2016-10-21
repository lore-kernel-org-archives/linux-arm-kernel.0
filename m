From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Oct 2016 09:13:01 +0200
Subject: [PATCH] pwm: meson: Remove unneeded platform MODULE_ALIAS
In-Reply-To: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
References: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20161021071301.GC2670@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 04:49:59PM -0300, Javier Martinez Canillas wrote:
> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
> 
> So there's no need to have a MODULE_ALIAS("platform:meson-pwm") since
> the reported uevent MODALIAS to user-space will always be the OF one.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/pwm/pwm-meson.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161021/6e99fd32/attachment-0001.sig>
