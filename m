From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 29 Oct 2018 11:46:15 +0100
Subject: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
In-Reply-To: <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
Message-ID: <CAJKOXPfuUFzFFwJoPutQz+zYqtom8evscpq2=PafX1EbBAnC+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2018 at 20:54, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The legacy PWM API should be removed in the long run, so convert a user
> to the atomic PWM API.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
I see this depends on first patch so I assume this will go through pwm tree.

Best regards,
Krzysztof
