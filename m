From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 13:08:09 +0200
Subject: [PATCH v5 03/46] backlight: lm3630a_bl: stop messing with the
 pwm->period field
In-Reply-To: <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160412110809.GI18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:03:26PM +0200, Boris Brezillon wrote:
> pwm->period field is not supposed to be changed by PWM users. The only
> ones authorized to change it are the PWM core and PWM drivers.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/d03ae890/attachment-0001.sig>
