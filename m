From: khilman@ti.com (Kevin Hilman)
Date: Fri, 07 Jan 2011 15:17:05 -0800
Subject: [PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes
In-Reply-To: <1294441282-17986-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 7 Jan 2011 17:01:19 -0600")
References: <1294441282-17986-1-git-send-email-nm@ti.com>
Message-ID: <87sjx4jocu.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> As discussed in the threads:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
> http://marc.info/?t=121540030800004&r=1&w=2
>
> here is the split up series with commit message after discussion:
> http://www.beagleboard.org/irclogs/index.php?date=2011-01-06#T19:12:21
>
> Koen Kooi (3):
>   omap3: beaglexm: fix EHCI power up GPIO dir
>   omap3: beaglexm: fix DVI reset GPIO
>   omap3: beaglexm: fix power on of DVI
>
>  arch/arm/mach-omap2/board-omap3beagle.c |   37 ++++++++++++++++++++++++++----
>  1 files changed, 32 insertions(+), 5 deletions(-)
>
> v4:
>   no functional change.
>   minor cleanups in commit logs incorporating offline feedback

Thanks for the updates.  Will queue in  my fixes queue.

Kevin

> v3: http://marc.info/?t=129434384700006&r=1&w=2
> 	split up the series, addressed review comments
>
> v2: http://marc.info/?t=129276977900002&r=1&w=2
> 	Reenable the PMU stat LED
> v1: http://marc.info/?t=129172571000001&r=1&w=2
>
> Regards,
> Nishanth Menon
