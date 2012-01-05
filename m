From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jan 2012 20:15:26 +0800
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <20120105113106.GR11810@n2100.arm.linux.org.uk>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20111219071350.GH4962@S2100-06.ap.freescale.net>
 <4EEEE40C.3000200@bluegiga.com>
 <20111219091916.GJ4962@S2100-06.ap.freescale.net>
 <20111219091322.GD14542@n2100.arm.linux.org.uk>
 <20120104135204.GA14741@S2100-06.ap.freescale.net>
 <20120104211800.GF11810@n2100.arm.linux.org.uk>
 <20120105113106.GR11810@n2100.arm.linux.org.uk>
Message-ID: <20120105121523.GE1729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 11:31:06AM +0000, Russell King - ARM Linux wrote:
> I'll change that - as 3.2 was released last night.  I'm not going to
> update mach-types now as that would be suicide - updating it will
> mean a bunch of entries will be deleted, and we don't know whether that
> will cause build failures.
> 
> So... not this side of the merge window.

Ok, thanks for letting us know.

Lauri,

It seems that you have to split the mxs_defconfig change out, so that
I can send the patch to Arnd without waiting for mach-types update.
And we can send mxs_defconfig update later when mach-types update hits
mainline.

We really need to take the action quickly, or the patch will likely
miss another merge window.

-- 
Regards,
Shawn
