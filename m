From: shubhrajyoti@ti.com (Datta, Shubhrajyoti)
Date: Mon, 23 Jul 2012 22:57:48 +0530
Subject: [PATCH 09/25] i2c/i2c-omap: add a const qualifier
In-Reply-To: <1343034810-3386-10-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-10-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CANQgH-Yx_iA0ANSLGjzgttBAfDFTJFQqYdo2PpJvtGN8=rdTrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 2:43 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
>         drivers/i2c/busses/i2c-omap.c:1025: warning: assignment discards qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
