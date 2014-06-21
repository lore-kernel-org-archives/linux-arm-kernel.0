From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 20:36:06 -0400
Subject: [PATCH 1/5] ARM: mvebu: remove stub implementation of CPU
 hotplug on Armada 375/38x
In-Reply-To: <1401481098-23326-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1401481098-23326-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140621003606.GT21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 10:18:14PM +0200, Thomas Petazzoni wrote:
> In preparation to the addition of CPU hotplug support for Armada XP,
> and therefore moving the existing stub functions for hotplug support,
> this commit removes the reference from the SMP implementation of
> Armada 375/38x to the armada_xp_cpu_die() function. Proper CPU hotplug
> support for Armada 375 and 38x will be implemented at a later point.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/platsmp-a9.c | 3 ---
>  1 file changed, 3 deletions(-)

Patches 1-4 applied to mvebu/soc

thx,

Jason.
