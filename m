From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 3 Jan 2012 19:45:14 +0100
Subject: [GIT PULL] i.MX patches for eukrea boards
In-Reply-To: <CAOesGMizj-B4+3tFGMJY0=6e79g+OmzRn+Ou3R5eM_PLJUU=cQ@mail.gmail.com>
References: <20120103085137.GH5446@pengutronix.de>
 <CAOesGMizj-B4+3tFGMJY0=6e79g+OmzRn+Ou3R5eM_PLJUU=cQ@mail.gmail.com>
Message-ID: <20120103194514.258d4a91@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Sascha,

Le Tue, 3 Jan 2012 09:37:52 -0800,
Olof Johansson <olof@lixom.net> a ?crit :
> On Tue, Jan 3, 2012 at 12:51 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Arnd, Olof,
> >
> > Please pull the following eukrea board specific patches. They
> > currently conflict with the patches merging mach-mx5 to mach-imx.
> > Let me know if I have to rebase them.
> >
> > Sascha
> >
> > The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:
> >
> > ?Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)
> >
> > are available in the git repository at:
> > ?git://git.pengutronix.de/git/imx/linux-2.6.git imx-features-eukrea
> >
> > Eric B?nard (9):
> > ? ? ?mxc_udc: add workaround for ENGcm09152 for i.MX25
> > ? ? ?eukrea_cpuimx25: enable workaround ENGcm09152
> > ? ? ?mbimxsd25: add spi controler and spidev support
> > ? ? ?cpuimx25: add watchdog support
> > ? ? ?mbimxsd35: add spi controler and spidev support
> > ? ? ?eukrea-cpuimx51: remove board
> > ? ? ?cpuimx51sd: add watchdog support
> > ? ? ?mbimx51sd: add audio codec support
> > ? ? ?eukrea-cpuimx51sd: support rev2 PCB
> 
> Can you please change the patch subjects of these and future patches.
> They should generally be on the form:
> 
> ARM: <platform>: <subplatform or topic>: <...>
> 
> So, in your case:
> 
> ARM: imx: ...
> 
will send a v2 tomorrow

Eric
