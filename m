From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Tue, 2 Jun 2015 21:59:24 +0300
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <20150530164655.GM2067@n2100.arm.linux.org.uk>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
 <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
 <20150530164655.GM2067@n2100.arm.linux.org.uk>
Message-ID: <20150602185924.GO12550@lakka.kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 30, 2015 at 05:46:56PM +0100, Russell King - ARM Linux wrote:
> Note that drm/drm.h is all that should need to be included - drm/drm.h
> takes care of including linux/types.h when building on Linux platforms.
> (note: if your compiler doesn't set __linux__ then you're probably not
> using the proper compiler...)

Thanks, I'll fix this by including only drm/drm.h in exynos_drm.h,
nouveau_drm.h, radeon_drm.h and via_drm.h patches.

I'm using standard gcc from Debian for the x86 compilation.

-Mikko
