From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Mar 2012 14:28:40 +0100
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20120330132256.GI3254@S2101-09.ap.freescale.net>
References: <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
 <20120104135204.GA14741@S2100-06.ap.freescale.net>
 <20120104211800.GF11810@n2100.arm.linux.org.uk>
 <20120105113106.GR11810@n2100.arm.linux.org.uk>
 <20120330131320.GH3254@S2101-09.ap.freescale.net>
 <20120330131509.GE22981@n2100.arm.linux.org.uk>
 <20120330132256.GI3254@S2101-09.ap.freescale.net>
Message-ID: <20120330132840.GG22981@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 09:22:59PM +0800, Shawn Guo wrote:
> I have seen it's on the linux-next at the early time of the cycle,
> but I have to admit that I have not done that at the later time.

Well, I did lose track of which branches I had in linux-next during this
last cycle, which is probably how it got dropped.

The last update gave this against mainline:

 arch/arm/tools/mach-types |  186 ++++++++++++++++++++++++--------------------
 1 files changed, 101 insertions(+), 85 deletions(-)

and the latest update gives this also against mainline:

 arch/arm/tools/mach-types |  416 ++++++++++++++++++++++++---------------------
 1 files changed, 219 insertions(+), 197 deletions(-)

so that's 196 platform IDs deleted, which is way too much to be 'safe'.
