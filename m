From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 09:50:50 +0200
Subject: [RFC PATCH 02/15] pwm: fix pwm_get_period and pwm_get_duty_cycle
 prototypes
In-Reply-To: <1435738921-25027-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720075049.GC29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:48AM +0200, Boris Brezillon wrote:
> The pwm argument is not modified in pwm_get helpers, make it a const
> argument so that they can be used from the sysfs functions.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/pwm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied with a slightly reworded commit message. The prototypes weren't
"broken" so there's nothing to "fix". Also s/pwm/PWM/.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/ddba6f65/attachment.sig>
