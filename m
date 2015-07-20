From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 10:00:09 +0200
Subject: [RFC PATCH 04/15] pwm: make use of pwm_get_xxx helpers where
 appropriate
In-Reply-To: <1435738921-25027-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720080008.GE29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:50AM +0200, Boris Brezillon wrote:
> Use the pwm_get_xxx helpers instead of directly accessing the fields in
> pwm_device. This will allow us to smoothly move to the atomic update
> approach.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-atmel.c    |  2 +-
>  drivers/pwm/pwm-bcm-kona.c |  3 ++-
>  drivers/pwm/pwm-imx.c      |  3 ++-
>  drivers/pwm/pwm-rockchip.c |  2 +-
>  drivers/pwm/sysfs.c        | 11 ++++++-----
>  5 files changed, 12 insertions(+), 9 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/abdcd159/attachment.sig>
