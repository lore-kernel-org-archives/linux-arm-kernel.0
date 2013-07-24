From: horms@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 17:07:06 +0900
Subject: [PATCH 06/08] ARM: shmobile: Remove Kota2 use of <mach/hardware.h>
In-Reply-To: <20130724033811.30567.3910.sendpatchset@w520>
References: <20130724033715.30567.82782.sendpatchset@w520>
 <20130724033811.30567.3910.sendpatchset@w520>
Message-ID: <20130724080705.GL10027@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 12:38:11PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove unused <mach/hardware.h> on Kota2.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I have skipped this patch as the cleanup2 branch, where I am applying
other patches in this series, includes a patch to remove Kota2.
