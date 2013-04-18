From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Apr 2013 22:30:22 +0900
Subject: [PATCH 4/4] ARM: shmobile: Marzen: enable VIN and ADV7180 in
 defconfig
In-Reply-To: <201304180217.28176.sergei.shtylyov@cogentembedded.com>
References: <201304180206.39465.sergei.shtylyov@cogentembedded.com>
 <201304180217.28176.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130418133022.GD20929@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 02:17:27AM +0400, Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add the VIN and ADV7180 drivers to 'marzen_defconfig'.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/configs/marzen_defconfig |    7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, queued-up for v3.11 in the defconfig-marzen branch.
