From: balbi@ti.com (Felipe Balbi)
Date: Fri, 7 Jan 2011 15:10:17 +0200
Subject: Build breakage with omap2plus_defconfig
In-Reply-To: <48d62e319848b713fc70a8298c32710d@mail.gmail.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
	<8663c7bb00ba574693af177a10e24043@mail.gmail.com>
	<20110107125929.GD9592@legolas.emea.dhcp.ti.com>
	<48d62e319848b713fc70a8298c32710d@mail.gmail.com>
Message-ID: <20110107131017.GE9592@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 07, 2011 at 06:35:39PM +0530, Santosh Shilimkar wrote:
> This patch is good but it does tell you that if
> you will V6 and v7 together, the feature can't be used.
> 
> Like omap2plus_defconfig, and if booted on
> say omap3 or omap4(v7), swp emulation can't be used
> even though its supported.

Sure, I got that from the patch, but we don't have any other simpler
solution currently. And it's indeed a shame we can't support multi-omap
anymore :-(

-- 
balbi
