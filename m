From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Jul 2010 14:31:44 -0400 (EDT)
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <AANLkTilY0rvbp7brGsnyuGhPjFvpVYInNWlAlf5tT4zG@mail.gmail.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<AANLkTilY0rvbp7brGsnyuGhPjFvpVYInNWlAlf5tT4zG@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1007161429121.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jul 2010, Grant Likely wrote:
> On Fri, Jul 16, 2010 at 12:19 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > For example, if I want CONFIG_MTD_CMDLINE_PARTS=y, the system may be
> > smart enough to notice and automatically enable CONFIG_MTD and
> > CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.
> 
> I fully agree.  However, the warnings make the system work now while
> we wait for a full solver to be implemented.

Why can't the tool just _select_ the option it is warning about when a 
dependency is not met?  That shouldn't require a full solver.


Nicolas
