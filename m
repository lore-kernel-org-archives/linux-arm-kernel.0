From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 May 2011 22:42:09 -0400 (EDT)
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <BANLkTim_0eRvDkQwAYjTNQsOVQiHV+DdBQ@mail.gmail.com>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTim_0eRvDkQwAYjTNQsOVQiHV+DdBQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1105182234130.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 May 2011, Barry Song wrote:

> does it mean if we want to add a new SoC plat/mach, we will send
> patches againest this tree?

Yes.  Or against latest mainline tree from Linus.

> will this tree merge into rmk's tree? then rmk's tree will only manage
> arm common codes?

Something like that.  The exact details will be fleshed out as we go. 
The idea is to give a round of review from a higher point of view to 
make sure no opportunities for code reuse is missed, etc.  The mechanics 
of how this code transitions from this tree into mainline during the 
merge window is secondary.


Nicolas
