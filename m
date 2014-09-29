From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 30 Sep 2014 01:42:31 +0200
Subject: [PATCH v2 1/6] cpufreq: dt: disable unsupported OPPs
In-Reply-To: <1411979088.2625.1.camel@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
 <3967829.hlAL1lU4Xl@vostro.rjw.lan> <1411979088.2625.1.camel@pengutronix.de>
Message-ID: <1915959.KRxr8m7sM7@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 29, 2014 10:24:48 AM Lucas Stach wrote:
> Am Freitag, den 26.09.2014, 23:55 +0200 schrieb Rafael J. Wysocki:
> > On Friday, September 26, 2014 03:40:59 PM Lucas Stach wrote:
> > > If the regulator connected to the CPU voltage plane doesn't
> > > support an OPP specified voltage with the acceptable tolerance
> > > it's better to just disable the OPP instead of constantly
> > > failing the voltage scaling later on.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > Why do you need this to be part of the whole series?  Is there any
> > hard dependency on it?
> > 
> No there isn't any hard dependency. It's just that one of the boards I
> was testing this series with needs this to properly disable one invalid
> OPP.
> 
> So it's no problem to rip this one out of the series. Sorry for the
> confusion.

OK

Please resend it as a separate fix, then.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
