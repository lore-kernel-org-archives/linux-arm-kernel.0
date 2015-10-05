From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Oct 2015 17:16:29 +0200
Subject: [PATCH] pwm: atmel-hlcdc: add sama5d2 SoC support.
In-Reply-To: <1441805550-11553-1-git-send-email-nicolas.ferre@atmel.com>
References: <1441805550-11553-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20151005151629.GA17612@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 03:32:30PM +0200, Nicolas Ferre wrote:
> Add sama5d2 hlcdc backlight PWM support. This chip doesn't have to deal with an
> errata, so it's a simple addition of the mfd compatible string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/43b94bd8/attachment.sig>
