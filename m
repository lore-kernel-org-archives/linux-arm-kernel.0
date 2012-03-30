From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 21:22:59 +0800
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20120330131509.GE22981@n2100.arm.linux.org.uk>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
 <20120104135204.GA14741@S2100-06.ap.freescale.net>
 <20120104211800.GF11810@n2100.arm.linux.org.uk>
 <20120105113106.GR11810@n2100.arm.linux.org.uk>
 <20120330131320.GH3254@S2101-09.ap.freescale.net>
 <20120330131509.GE22981@n2100.arm.linux.org.uk>
Message-ID: <20120330132256.GI3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 02:15:10PM +0100, Russell King - ARM Linux wrote:
...
> Well, it seems I've been missing having that branch in linux-next for
> almost the entire previous cycle.  It would be utterly irresponsible
> to now commit that into mainline because of the -now- huge number of
> platform IDs that it deletes.
> 
I can live with that since mxs_defconfig has not enabled it.
randconfig build will probably complain though.

> I assume, therefore, that you don't keep an eye on what's in linux-next.

I have seen it's on the linux-next at the early time of the cycle,
but I have to admit that I have not done that at the later time.

-- 
Regards,
Shawn
