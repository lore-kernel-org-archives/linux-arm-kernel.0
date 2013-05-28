From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 28 May 2013 17:05:46 +0200
Subject: [PATCH v4 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <CAOMZO5BJ7h=_cqSUG6X25SHTMe5ym1_nToj5P_PMR9bxN+B2Ow@mail.gmail.com>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
 <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
 <CAOMZO5BJ7h=_cqSUG6X25SHTMe5ym1_nToj5P_PMR9bxN+B2Ow@mail.gmail.com>
Message-ID: <1369753546.4000.4.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Montag, den 27.05.2013, 13:25 -0300 schrieb Fabio Estevam:
> On Tue, Feb 26, 2013 at 8:39 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > This driver implements a reset controller device that toggles gpios
> > connected to reset pins of peripheral ICs. The delay between assertion
> > and de-assertion of the reset signal can be configured.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Looks good and it is a very useful binding.
> 
> Will anyone apply this?

I have tried to address Olof's concerns by making the gpio-reset driver
only handle a single gpio per device.

I'll send a new patch for review.

regards
Philipp
