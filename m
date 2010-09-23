From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 24 Sep 2010 00:12:19 +0200 (CEST)
Subject: [PATCH 1/8] posix clocks: introduce a syscall for clock
 tuning.
In-Reply-To: <1285279423.5158.20.camel@pasglop>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<b94ef1cd9c04ef3ad5964408bd0af7251add78de.1285261534.git.richard.cochran@omicron.at>
	<1285279423.5158.20.camel@pasglop>
Message-ID: <alpine.LFD.2.00.1009240008390.2416@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Sep 2010, Benjamin Herrenschmidt wrote:
> On Thu, 2010-09-23 at 19:31 +0200, Richard Cochran wrote:
> > The new syscall, clock_adjtime, takes two parameters, the clock ID,
> > and a pointer to a struct timex. The semantics of the timex struct
> > have been expanded by one additional mode flag, which allows an
> > absolute offset correction. When specificied, the clock offset is
> > immediately corrected by adding the given time value to the current
> > time value.
> 
> Any reason why you CC'ed device-tree discuss ?
> 
> This list is getting way too much unrelated stuff, which I find
> annoying, it would be nice if we were all a bit more careful here with
> our CC lists.

Says the guy who missed to trim the useless context of the original
mail, which made me scroll down all the way just to find out that
there is nothing to see.

Thanks,

	tglx
