From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Apr 2013 11:15:30 +0900
Subject: [PATCH 4/4] ARM: shmobile: Marzen: enable VIN and ADV7180 in
 defconfig
In-Reply-To: <51700158.101@cogentembedded.com>
References: <201304180206.39465.sergei.shtylyov@cogentembedded.com>
 <201304180217.28176.sergei.shtylyov@cogentembedded.com>
 <20130418133022.GD20929@verge.net.au>
 <51700158.101@cogentembedded.com>
Message-ID: <20130419021530.GD25718@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 06:21:12PM +0400, Sergei Shtylyov wrote:
> On 18-04-2013 17:30, Simon Horman wrote:
> 
> >>From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> >>Add the VIN and ADV7180 drivers to 'marzen_defconfig'.
> 
> >>Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>---
> >>  arch/arm/configs/marzen_defconfig |    7 +++++++
> >>  1 file changed, 7 insertions(+)
> 
> >Thanks, queued-up for v3.11 in the defconfig-marzen branch.
> 
>    That seems somewhat premature as CONFIG_VIDEO_RCAR_VIN is not
> defined yet (it's defined in the patch #1 of this series).

Sorry about that, I have dropped the patch.
