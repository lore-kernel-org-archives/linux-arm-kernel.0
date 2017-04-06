From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Apr 2017 16:16:31 +0200
Subject: [PATCH] pwm: atmel-hlcdc: Implement the suspend/resume hooks
In-Reply-To: <1488379947-13123-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1488379947-13123-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170406141631.GC8438@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 03:52:27PM +0100, Boris Brezillon wrote:
> Implement the suspend/resume hooks to make sure the PWM device is
> restored to a correct state after a suspend.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> This patch depends on the atomic conversion patch [1].
> 
> [1]https://patchwork.ozlabs.org/patch/734251/
> 
>  drivers/pwm/pwm-atmel-hlcdc.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/e09a9dfd/attachment.sig>
