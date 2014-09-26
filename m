From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 11:32:35 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v3.18
In-Reply-To: <542501A1.8020807@monstr.eu>
References: <541819FD.5000301@monstr.eu> <201409251746.14540.arnd@arndb.de>
 <542501A1.8020807@monstr.eu>
Message-ID: <9601562.uSNV2qlMfC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014 08:03:13 Michal Simek wrote:
> On 09/25/2014 05:46 PM, Arnd Bergmann wrote:
> > On Tuesday 16 September 2014, Michal Simek wrote:
> >>   git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.18
> >>
> >> for you to fetch changes up to 8097171e19bb69f3e2226827440b71ececa5d74f:
> >>
> >>   ARM: zynq: Remove useless L2C AUX setting (2014-09-16 12:55:12 +0200)
> >>
> >> ----------------------------------------------------------------
> >> arm: Xilinx Zynq cleanup patches for v3.18
> >>
> >> - PM support
> >> - Fix L2 useless setting
> > 
> > I don't see why this counts as cleanup when you add so much more code
> > than you remove, but the individual changes all make sense, so I've
> > pulled it into next/soc.
> 
> What's the branch name for adding new stuff? I see people are using soc.
> 
> 

next/soc is usually for code that is shared by an soc family. Some platforms
also still have board specific files (you dont'), that would go into
next/board.

Ideally all cleanups should come first and get submitted into next/cleanup,
while any other changes that interact with the cleanups can be done on
top of that first branch and merged into the respective topic branches.

	Arnd
