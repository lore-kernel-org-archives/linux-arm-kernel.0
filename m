From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 28 Feb 2014 11:27:46 +0100
Subject: [PATCH] gpio: only enable kona driver on BCM_MOBILE or for
 compile testing
In-Reply-To: <CAPdLdqkq06AuLr8a8x9aY8BmHHbcNsL5tmQrH4j8bEom_HS-kA@mail.gmail.com>
References: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAPdLdqkq06AuLr8a8x9aY8BmHHbcNsL5tmQrH4j8bEom_HS-kA@mail.gmail.com>
Message-ID: <20140228102746.GN6865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

On Thu, Feb 27, 2014 at 02:20:17PM -0800, Markus Mayer wrote:
> On 21 February 2014 05:42, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > I'm not sure if and how "Kona" fits into the bcm281xx namespace, but
> > reading through the commit logs of the changes touching
> > drivers/gpio/gpio-bcm-kona.c so far suggests it does. In this case I'd
> > consider it a good idea to mention "bcm281xx" in the help text of
> > GPIO_BCM_KONA.
> 
> Naming these components has been quite a challenge for our upstreaming
> effort. Some things are not very obvious unless you know he chip or
> were involved in those discussions.
> 
> "Kona" can be thought of as an architecture or a family of chips.
> bcm281xx is one member of that family. There are others. I submitted
> bcm21664 to arm-linux just a few minutes ago. bcm21664 also uses
> gpio-bcm-kona.c.
> 
> Mentioning the SoCs in the help text is a good idea, but we'll likely
> have to come up with a central location where all supported members of
> the Kona family are listed, so they aren't scattered all over
> different sub-systems (Kona watchdog, Kona GPIO, Kona timer, etc.) If
> we don't have a central location, we'll be certain to forget updating
> one of the help texts eventually, and it would become inconsistent.
Fine for me, but note that this was only a side node and is orthogonal
to the patch I sent. So if you want to ack it ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
