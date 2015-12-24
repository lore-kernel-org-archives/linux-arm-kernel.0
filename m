From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Dec 2015 11:18:32 +0100
Subject: [PATCH v3 2/2] dts/ls2080a: Update DTSI to add support of SP805
 WDT
In-Reply-To: <CAFTCetS7P6wF3MhgMSXSXP_jnLQvBc-NSY0TW3OOnCjtbL0N_w@mail.gmail.com>
References: <1450189825-29065-1-git-send-email-bhupesh.sharma@freescale.com>
 <1450189825-29065-3-git-send-email-bhupesh.sharma@freescale.com>
 <CAFTCetS7P6wF3MhgMSXSXP_jnLQvBc-NSY0TW3OOnCjtbL0N_w@mail.gmail.com>
Message-ID: <201512241118.32946.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 December 2015, Bhupesh SHARMA wrote:
> 
> Hi Arnd, Olof, Kevin
> 
> On Tue, Dec 15, 2015 at 8:00 PM, Bhupesh Sharma
> <bhupesh.sharma@freescale.com> wrote:
> > This patch updates the LS2080a DTSI (DTS Include) file to add
> > support for eight SP805 Watchdog units which can be used to
> > reset the eight Cortex-A57 cores available on LS2080A.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   56 ++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> 
> Since Rob has acked the SP805 WDT binding documentation patch (patch
> 1/2 of this series),
> can this DTSI change, please be considered for absorption in the arm-soc tree.

Sure, please submit it for inclusion. Who is the maintainer for
arch/arm64/boot/dts/freescale/ ? Can they pick up all the freescale related
dts changes and submit them as a pull request? Should they go through
Shawn's tree maybe?

	Arnd
