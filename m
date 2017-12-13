From: joonas.lahtinen@linux.intel.com (Joonas Lahtinen)
Date: Wed, 13 Dec 2017 10:01:51 +0200
Subject: [PATCH V3 09/29] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <055279d0-5e1b-621c-af8e-4c2704d54e8c@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <bd6c6365-c265-30f4-029b-3e19af3078f2@codeaurora.org>
 <1513087456.3809.17.camel@linux.intel.com>
 <055279d0-5e1b-621c-af8e-4c2704d54e8c@codeaurora.org>
Message-ID: <1513152111.5228.1.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-12 at 19:07 -0500, Sinan Kaya wrote:
> On 12/12/2017 9:04 AM, Joonas Lahtinen wrote:
> > Hi,
> > 
> > I sent this individual i915 patch to our CI, and it is passing on
> > all platforms:
> > 
> > https://patchwork.freedesktop.org/series/34822/
> > 
> > Is it ok if I merge this to drm-tip already?
> 
> As long as you have this change in your tree, it should be safe.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/pci.h?id=7912af5c835bd86f2b0347a480e0f40e2fab30d0
> 

We don't yet.

Rodrigo, can you please pull the above patch in once we get a
backmerge?

Regards, Joonas
-- 
Joonas Lahtinen
Open Source Technology Center
Intel Corporation
