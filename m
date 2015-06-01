From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Mon, 1 Jun 2015 12:15:31 +0300
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <556C15BA.7000909@amd.com>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
 <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
 <20150530164655.GM2067@n2100.arm.linux.org.uk>
 <556C15BA.7000909@amd.com>
Message-ID: <20150601091531.GL12550@lakka.kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 10:20:10AM +0200, Christian K?nig wrote:
> Additional to that "linux/types.h" is not part of the uapi as far as
> I know, so including it in a header which is part of the uapi should
> be forbidden.

linux/types.h is part of uapi. See usr/include after 'make headers_install'.

-Mikko
