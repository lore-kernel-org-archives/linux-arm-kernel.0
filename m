From: khilman@ti.com (Kevin Hilman)
Date: Wed, 02 Nov 2011 15:27:25 -0700
Subject: [GIT PULL] gpio/omap: minor cleanups for v3.2
In-Reply-To: <8739g91dp5.fsf@ti.com>
References: <8739g91dp5.fsf@ti.com>
Message-ID: <4EB1C3CD.4030907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 09/06/2011 03:57 PM, Kevin Hilman wrote:
> Grant,
> 
> Please pull the following OMAP GPIO cleanups for v3.2.
> 
> Just a heads up: we're also working on another large series of cleanup
> for this driver that we'll be trying to merge for v3.2.
> 
> Kevin

I don't see this in linux-next or your gpio/next branch.  Are you
planning to pull this for v3.2?

Kevin

> 
> The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
> 
>   Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/khilman/linux-omap-pm.git for_3.2/gpio-cleanup
> 
> Kevin Hilman (1):
>       gpio/omap: replace MOD_REG_BIT macro with static inline
> 
> Todd Poynor (1):
>       gpio/omap: check return value from irq_alloc_generic_chip
> 
>  drivers/gpio/gpio-omap.c |   59 ++++++++++++++++++++++++++-------------------
>  1 files changed, 34 insertions(+), 25 deletions(-)
