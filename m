From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 07 Feb 2015 09:38:04 +0100
Subject: [PATCH 0/4] ASoC: samsung: clean up references to outdated
 Kconfig symbols
In-Reply-To: <20150206235044.GO31311@finisterre.sirena.org.uk>
References: <1421664067.9655.51.camel@x220>
 <20150206235044.GO31311@finisterre.sirena.org.uk>
Message-ID: <1423298284.2246.5.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-02-07 at 07:50 +0800, Mark Brown wrote:
> On Mon, Jan 19, 2015 at 11:41:07AM +0100, Paul Bolle wrote:
> > A few series of ARM cleanups regarding S5PC100 and S5PV210 were included
> > in v3.17. These series removed these five Kconfig symbols:
> >     MACH_AQUILA
> >     MACH_GONI
> >     MACH_SMDKC100
> >     MACH_SMDKC110
> >     MACH_SMDKV210
> > 
> > This series, done on top of next-20150119, removes the remaining
> 
> If you are posting a patch series please ensure that all the patches in
> the series are threaded in reply to the cover letter (or first patch if
> there isn't one) so that mail clients can see to display them as a
> series.

Patches 2/4, 3/4, and 4/4 didn't apply. Locally I carry them in a tree
that constantly rebases on top of linux-next. So locally I carry these
patches on top of next-20150204.

What tree would you like me to rebase this onto?


Paul Bolle
