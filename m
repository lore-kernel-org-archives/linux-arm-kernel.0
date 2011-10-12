From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 11 Oct 2011 20:03:38 -0400 (EDT)
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <2414781.rlNqTThJUN@wuerfel>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
	<20111011184821.GA11839@mudshark.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
Message-ID: <alpine.LFD.2.02.1110111950290.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Oct 2011, Arnd Bergmann wrote:

> I've stuck them into the arm-soc tree for now, so we get linux-next
> coverage, but I won't send them to Linus this way because then we
> would get the same commits twice in the history.

Could you please do the same with the following:

  git://git.linaro.org/people/nico/linux.git mach_memory_h

Russell pulled it at some point, and dropped it due to concerns about 
repeated conflict resolutions (or so I presume).  I just did a test 
merge between your for-next branch and the above and that looked trivial 
enough.


Nicolas
