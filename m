From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Dec 2013 13:12:34 -0500
Subject: [PATCH 0/2] ARM: mvebu: additional cleanups
In-Reply-To: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131227181234.GC19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 09:20:24AM +0100, Thomas Petazzoni wrote:
> Jason, Gregory, Andrew, Sebastian,
> 
> Here are two additional minor cleanups to the mach-mvebu code
> base. They are intended for mvebu/soc. Note that they are based on
> 3.13-rc5, so there might be some conflicts while applying them to
> mvebu/soc, but the resolution should be trivial considering how simple
> the patches are.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (2):
>   ARM: mvebu: remove prototypes of non-existing functions from common.h
>   ARM: mvebu: move Armada 370/XP specific definitions to armada-370-xp.h
> 
>  arch/arm/mach-mvebu/armada-370-xp.h | 2 ++
>  arch/arm/mach-mvebu/common.h        | 8 +-------
>  2 files changed, 3 insertions(+), 7 deletions(-)

Whole series applied to mvebu/soc

thx,

Jason.
