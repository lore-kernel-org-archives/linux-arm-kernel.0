From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Aug 2012 15:58:29 +0200
Subject: [PATCH v2 2/2] ARM: imx/pcm043: add oftree support
In-Reply-To: <CAOMZO5D=1XfV==+VvgzsJccLPiGd6xDCjVSRYxrH0VMzEtX_gg@mail.gmail.com>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5D=1XfV==+VvgzsJccLPiGd6xDCjVSRYxrH0VMzEtX_gg@mail.gmail.com>
Message-ID: <20120810135829.GK25520@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Fri, Aug 10, 2012 at 10:38:02AM -0300, Fabio Estevam wrote:
> On 8/10/12, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > +			serial at 43f90000 {
> > +				status = "okay";
> > +			};
> > +
> > +			serial at 43f94000 {
> > +				status = "okay";
> 
> On other i.mx boards the format is:
> 
> uart1: serial at 43f90000
> 
> Should the same be done here?
I don't care much, but I like to minimize duplication. As dtc bails out
if you get it wrong it would be ok for me to keep the label.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
