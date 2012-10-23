From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Oct 2012 14:41:28 +0000
Subject: [PATCH v2 0/4] zynq subarch cleanups
In-Reply-To: <20121022211040.GA31538@beefymiracle.amer.corp.natinst.com>
References: <20121022211040.GA31538@beefymiracle.amer.corp.natinst.com>
Message-ID: <201210231441.29107.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 October 2012, Josh Cartwright wrote:
> Hey all-
> 
> Things have been relatively quiet on the Zynq front lately.  This
> patchset does a bit of cleanup of the Zynq subarchitecture.  It was the
> necessary set of things I had to do to get a zynq target booting with
> the upstream qemu model.  It removes some unused clock infrastructure,
> adds DT support for the GIC, and moves around peripheral mappings.

Ok, thanks for these patches. As we have moved on for some of these issues,
I'll comment on how to go even further. On a global scale, I wonder
if there are any obstacles for enabling CONFIG_MULTIPLATFORM on Zynq
as we have done for most of the other recently added platform.

	Arnd
