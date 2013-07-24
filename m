From: horms@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 17:06:56 +0900
Subject: [PATCH 08/08] ARM: shmobile: Remove include <mach/hardware.h>
In-Reply-To: <20130724033829.30567.27355.sendpatchset@w520>
References: <20130724033715.30567.82782.sendpatchset@w520>
 <20130724033829.30567.27355.sendpatchset@w520>
Message-ID: <20130724080655.GJ10027@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 12:38:29PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Now when no one is using this file, remove <mach/hardware.h>.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the cleanup2 branch.
