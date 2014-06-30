From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 12:22:16 +0200
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17
In-Reply-To: <20140628172044.4231c32d@free-electrons.com>
References: <20140627124655.GF23978@titan.lakedaemon.net>
 <20140628162302.48b6b835@free-electrons.com>
 <20140628150706.GM23978@titan.lakedaemon.net>
 <20140628172044.4231c32d@free-electrons.com>
Message-ID: <20140630122216.6ea35ac9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Sat, 28 Jun 2014 17:20:44 +0200, Thomas Petazzoni wrote:

> Yeah, sorry, I wasn't clear. If you look back at what I sent in
> https://www.mail-archive.com/devicetree at vger.kernel.org/msg30473.html
> ([PATCHv5 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
> deadlock), there were three patches:
> 
>  PATCH 1/3, "ARM: mm: add support for HW coherent systems in PL310
>  cache", for Russell. It has already been merged by Russell in
>  "git-curr", as visible at
>  http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8076/1.
>  I'm hoping this is scheduled for 3.16, because I need this patch for
>  3.16 to avoid the PCIe deadlock.
> 
>  PATCH 2/3 and 3/3 are related, and the latter is needed to solve the
>  PCIe deadlock, by using the new DT property made available in PATCH
>  1/3. PATCH 2/3 is ARM: mvebu: move Armada 375 external abort logic as
>  a quirk and PATCH 3/3 is ARM: mvebu: update L2/PCIe deadlock
>  workaround after L2CC cleanup.
> 
> All in all, I'm hoping for the series at
> https://www.mail-archive.com/devicetree at vger.kernel.org/msg30473.html
> to fully show up in 3.16, because it's really related to fixing a
> serious PCIe deadlock (can be triggered in under a minute of PCIe
> usage).

Now that Russell is pushing PATCH 1/3 in the 3.16-rc cycle, can you
push PATCH 2/3 and PATCH 3/3 pointed above into the 3.16-rc cycle as
well?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
