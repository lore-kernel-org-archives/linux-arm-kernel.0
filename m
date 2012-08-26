From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 Aug 2012 04:41:25 +0000
Subject: [GIT PULL] ARM: mach-pnx4008: Remove architecture
In-Reply-To: <50378084.3080102@antcom.de>
References: <1345724548-18130-1-git-send-email-stigge@antcom.de>
 <50378084.3080102@antcom.de>
Message-ID: <201208260441.25905.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 August 2012, Roland Stigge wrote:
> On 23/08/12 14:22, Roland Stigge wrote:
> > This patch removes the ARM architecture mach-pnx4008. No direct support or user
> > feedback since 2006. Acknowledgements from NXP/Philips and Linux arm-soc
> > maintainers.
> > 
> > Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> The patch was a bit too big for the mailing list - sorry.
> 
> Now re-proposing via pull request, below.

I think the removal of the frame buffer driver should go separately via the
framebuffer maintainer (Florian Schandinat), I can take the rest through the
arm-soc tree.

	Arnd
