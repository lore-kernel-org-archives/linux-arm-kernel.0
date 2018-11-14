From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 Nov 2018 13:18:38 +0100
Subject: [PATCH 4/4] bus: ts-nbus: weaken driver dependency to allow
 broader compile testing
In-Reply-To: <20181026184157.16371-4-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-4-u.kleine-koenig@pengutronix.de>
Message-ID: <20181114121838.GF2620@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:41:58PM +0200, Uwe Kleine-K?nig wrote:
> There is nothing specific for the i.MX28 SoC in the ts-nbus driver and
> it compiles just fine with an ARM/s3c24xx configuration.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/bus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like Sebastien's email no longer exists. Seeing that this driver
was merged a year ago and doesn't have any in-kernel users I wonder if
there's any use in keeping it.

Arnd, this looks completely dead at this point and it doesn't seem like
this ever had any users, should we remove it?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/ca9804ba/attachment.sig>
