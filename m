From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 14:45:50 +0100
Subject: [PATCH 14/14] ASoC: sunxi: simplify optional reset handling
In-Reply-To: <20170130123046.fshkubkq6eo2mf7q@sirena.org.uk>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-14-p.zabel@pengutronix.de>
 <20170130123046.fshkubkq6eo2mf7q@sirena.org.uk>
Message-ID: <1485783950.2877.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-30 at 12:30 +0000, Mark Brown wrote:
> On Mon, Jan 30, 2017 at 12:41:16PM +0100, Philipp Zabel wrote:
> > As of commit bb475230b8e5 ("reset: make optional functions really
> > optional"), the reset framework API calls use NULL pointers to describe
> > optional, non-present reset controls.
> 
> I've only got this patch from the series, what's the story with
> dependencies and so on?

This is a cleanup series across subsystems. The referenced commit is the
only dependency, it only just got merged into the arm-soc tree. There
are no dependencies between patches of this series.

I could merge this through the reset tree with your acks or resend it
individually once the above commit hits mainline, whichever you prefer.

regards
Philipp
