From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 18:17:46 +0000
Subject: [GIT PULL] AT91: patches for v2.6.38-rc1
In-Reply-To: <4D309278.5010603@atmel.com>
References: <4D308F30.6070503@atmel.com>
	<20110114180455.GL15996@n2100.arm.linux.org.uk>
	<4D309278.5010603@atmel.com>
Message-ID: <20110114181746.GM15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 07:14:16PM +0100, Nicolas Ferre wrote:
> Le 14/01/2011 19:04, Russell King - ARM Linux :
> > On Fri, Jan 14, 2011 at 07:00:16PM +0100, Nicolas Ferre wrote:
> >> Hi Russell,
> >>
> >> Can you please pull those little changes for AT91? They add two 
> >> new boards already discussed on the mailing list and a little 
> >> cleanup patch:
> > 
> > Has this already been in linux-next?
> 
> I must admit that... no.
> 
> > We should only be merging new code during a merge window which has
> > already had visibility in linux-next, with the exception of bug fixes
> > and regression fixes.
> 
> I understand your point but those are only *board* files that are lying
> around for one or two months.
> I was really wishing to see them included in mainline during merge
> window as they are not core ARM nor AT91 files...

Okay for this time, but please ensure that stuff like this is in
linux-next before the merge window next time so that it can have
some exposure.
