From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 13:01:52 +0200
Subject: [PATCH v5 01/46] pwm: rcar: make use of pwm_is_enabled()
In-Reply-To: <1459368249-13241-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160412110152.GG18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:03:24PM +0200, Boris Brezillon wrote:
> Commit 5c31252c4a86 ("pwm: Add the pwm_is_enabled() helper") introduced a
> new function to test whether a PWM device is enabled or not without
> manipulating PWM internal fields.
> Hiding this is necessary if we want to smoothly move to the atomic PWM
> config approach without impacting PWM drivers.
> Fix this driver to use pwm_is_enabled() instead of directly accessing the
> ->flags field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/3a96bc1a/attachment.sig>
