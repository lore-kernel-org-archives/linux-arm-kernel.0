From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Dec 2015 16:38:09 +0100
Subject: [PATCH 0/3] pwm: bcm2835: improve clock handling
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20151216153809.GC28947@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 10:55:38PM +0000, Stefan Wahren wrote:
> With the upcoming PWM clock support the pwm-bcm2835 should take
> more care about the clock handling. But this patch series doesn't
> depend on these clock driver changes.
> 
> Stefan Wahren (3):
>   pwm: bcm2835: calculate scaler in pwm_config
>   pwm: bcm2835: prevent division by zero
>   pwm: bcm2835: fix email address specifiction
> 
>  drivers/pwm/pwm-bcm2835.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

All three patches applied with Eric's Reviewed-by, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/973a08fa/attachment-0001.sig>
