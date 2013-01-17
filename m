From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Jan 2013 16:16:44 +0100
Subject: [PATCH] sdma-imx: Add SDMA firmware for Freescale i.MX SOCs
In-Reply-To: <CAOMZO5DOEeiRyH6CfpR+q1pnYTOv4JSWgoUoO2x1LCS1UE5SJQ@mail.gmail.com>
References: <1358424987-22312-1-git-send-email-fabio.estevam@freescale.com>
 <20130117143856.GI8668@pengutronix.de>
 <CAOMZO5DOEeiRyH6CfpR+q1pnYTOv4JSWgoUoO2x1LCS1UE5SJQ@mail.gmail.com>
Message-ID: <20130117151644.GK8668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 12:58:41PM -0200, Fabio Estevam wrote:
> Hi Uwe,
> 
> On Thu, Jan 17, 2013 at 12:38 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> >> +LICENSE GRANT.? Freescale grants to you, free of charge, the
> > What is this '?' about?
> 
> Thanks for reviewing it.
> 
> I don't see this '?' on my original patch.
looking more closely it's not a literal '?', but:
	0000790: 6565 6d65 6e74 2e0a 2b0a 2b4c 4943 454e  eement..+.+LICEN
	00007a0: 5345 2047 5241 4e54 2ea0 2046 7265 6573  SE GRANT.. Frees
                                       ^
here ----------------------------------' you have a '\xa0' which is what
my Mutt chose to display as ?. Note in the line above there are also
some '\x0a' which look wrong.
 
> Could this be a mail issue at your side?
http://article.gmane.org/gmane.linux.ports.arm.kernel/210613 shows it,
too. (At least for me and my browser.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
