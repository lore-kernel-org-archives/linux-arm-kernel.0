From: shyam.saini@amarulasolutions.com (Shyam Saini)
Date: Tue, 23 Oct 2018 10:51:59 +0530
Subject: [PATCH V2] ARM: dts: imx6qdl-icore: Add missing stdout-path
 property
In-Reply-To: <20181018184532.xe2llbhwjuffgchx@pengutronix.de>
References: <20181018150305.21408-1-shyam.saini@amarulasolutions.com>
 <20181018184532.xe2llbhwjuffgchx@pengutronix.de>
Message-ID: <CA+drQ_OZHPSXoECX4z7oWEwNV11EUn=DviNa6nmDpWKBs2o8+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 12:15 AM Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Oct 18, 2018 at 08:33:05PM +0530, Shyam Saini wrote:
> > This would help us to get early boot logs by passing "earlycon" to
> > kernel bootargs.
> >
> > Further, by adding this we don't have to depend on complex earlyprintk
> > configs for early boot logs.
> >
> > Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
> minor nit: your S-o-b line should be the last thing you write. So it's
>
>         Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
>         Reviewed-by: Fabio Estevam <festevam@gmail.com>
>         Signed-off-by: John Maintainer <john@example.org>
>
> if John added the Reviewed-by tag and
>
>         Reviewed-by: Fabio Estevam <festevam@gmail.com>
>         Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
>         Signed-off-by: John Maintainer <john@example.org>
>
> if it was you.

Thanks a lot Uwe for your suggestion. I'll take care of this thing next time.
@Shawn would you please make the minor change as suggested by Uwe.
