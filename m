From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Apr 2013 11:10:17 +0100
Subject: [PATCH] ARM: shmobile: BOCK-W: enable CONFIG_PM_RUNTIME in
 defconfig
In-Reply-To: <201304170303.46193.sergei.shtylyov@cogentembedded.com>
References: <201304170303.46193.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130417101017.GW14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 03:03:45AM +0400, Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Enable CONFIG_PM_RUNTIME in 'bockw_defconfig' -- it's already used by TMU, SCI,
> I2C, and Ether drivers to control the clocks...
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130416' tag.

Maybe you should send it to Simon rather than me for initial merging, who
would presumably know if this is the right thing for this bockw platform?
