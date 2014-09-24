From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Sep 2014 10:06:25 +0200
Subject: [PATCH] gpio: only enable kona driver on BCM_MOBILE or for
 compile testing
In-Reply-To: <530FB808.5050802@broadcom.com>
References: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdZg5uoP5LurL5vOPCaKQu2B=neybuo=gwM_JT7UAhRkjg@mail.gmail.com>
 <530FB808.5050802@broadcom.com>
Message-ID: <20140924080625.GE3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 02:11:20PM -0800, Markus Mayer wrote:
> On 14-02-27 01:16 AM, Linus Walleij wrote:
> >On Fri, Feb 21, 2014 at 2:42 PM, Uwe Kleine-K?nig
> ><u.kleine-koenig@pengutronix.de> wrote:
> >
> >>This change makes it easier to configure a kernel for a real machine by
> >>not showing the option to enable it at all if COMPILE_TEST is off.
> >>
> >>Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >
> >Markus: can you ACK this patch?
> 
> Acked-by: Markus Mayer <mmayer@broadcom.com>
ping!

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
