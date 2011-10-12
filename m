From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Oct 2011 10:30:11 +0200
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <alpine.LFD.2.02.1110111950290.17040@xanadu.home>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<alpine.LFD.2.02.1110111950290.17040@xanadu.home>
Message-ID: <1837446.fiK2eIOO53@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 October 2011 20:03:38 Nicolas Pitre wrote:
> On Tue, 11 Oct 2011, Arnd Bergmann wrote:
> 
> > I've stuck them into the arm-soc tree for now, so we get linux-next
> > coverage, but I won't send them to Linus this way because then we
> > would get the same commits twice in the history.
> 
> Could you please do the same with the following:
> 
>   git://git.linaro.org/people/nico/linux.git mach_memory_h
> 
> Russell pulled it at some point, and dropped it due to concerns about 
> repeated conflict resolutions (or so I presume).  I just did a test 
> merge between your for-next branch and the above and that looked trivial 
> enough.

Ok, done.

	Arnd
