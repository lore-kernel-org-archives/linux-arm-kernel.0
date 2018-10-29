From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Oct 2018 12:33:37 +0100
Subject: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
In-Reply-To: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20181029113337.GA9500@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K?nig wrote:
> This helps to convert drivers from the legacy API to pwm_apply_state without
> having to make the aware of the configured polarity (and in some cases even
> period).
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  include/linux/pwm.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

You're going to have to at least Cc me on patches 2 & 3 so that I can
see how you intend this to be used.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/66f34692/attachment.sig>
