From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Sep 2012 16:18:21 -0700
Subject: [GIT PULL] ARM: mach-pnx4008: Remove architecture
In-Reply-To: <503A3402.7090508@antcom.de>
References: <1345724548-18130-1-git-send-email-stigge@antcom.de>
 <50378084.3080102@antcom.de> <201208260441.25905.arnd@arndb.de>
 <503A3402.7090508@antcom.de>
Message-ID: <20120905231821.GG32084@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 04:34:42PM +0200, Roland Stigge wrote:
> On 26/08/12 06:41, Arnd Bergmann wrote:
> > On Friday 24 August 2012, Roland Stigge wrote:
> >> On 23/08/12 14:22, Roland Stigge wrote:
> >>> This patch removes the ARM architecture mach-pnx4008. No direct support or user
> >>> feedback since 2006. Acknowledgements from NXP/Philips and Linux arm-soc
> >>> maintainers.
> >>>
> >>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> >>
> >> The patch was a bit too big for the mailing list - sorry.
> >>
> >> Now re-proposing via pull request, below.
> > 
> > I think the removal of the frame buffer driver should go separately via the
> > framebuffer maintainer (Florian Schandinat), I can take the rest through the
> > arm-soc tree.
> 
> Fine - consider the new pull request for arch-pnx4008, below.
> 
> (Patch for video is separate, now.)
> 
> Thanks,
> 
> Roland
> 
> 
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
> 
>   git://git.antcom.de/linux-2.6.git pnx4008-removal

Thanks, pulled into next/cleanup. If we can get an Ack out of the FB maintainer
for the driver removal we can pick that up too, or it can go in through his
tree.


-Olof
