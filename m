From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Nov 2018 10:15:37 +0100
Subject: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
In-Reply-To: <CAJKOXPfuUFzFFwJoPutQz+zYqtom8evscpq2=PafX1EbBAnC+Q@mail.gmail.com>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
 <CAJKOXPfuUFzFFwJoPutQz+zYqtom8evscpq2=PafX1EbBAnC+Q@mail.gmail.com>
Message-ID: <20181114091537.bvriiawz3rnamazl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 11:46:15AM +0100, Krzysztof Kozlowski wrote:
> On Fri, 26 Oct 2018 at 20:54, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The legacy PWM API should be removed in the long run, so convert a user
> > to the atomic PWM API.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/mach-s3c24xx/mach-rx1950.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> I see this depends on first patch so I assume this will go through pwm tree.

Right, I assume so, too. Unfortunately I didn't hear anything back from
Thierry about this because there seems to be a mail reception problem on
his end.

@Thierry: Could you find the problem? It would be great to get some
feedback from you regarding these patches. There are more pwm users that
could benefit from this change, but I first want some feedback about
this before investing more time here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
