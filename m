From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Oct 2012 12:57:11 +0000
Subject: [PATCH] ARM: multiplatform: Add a defconfig for multi_v5
In-Reply-To: <1350461444-22832-1-git-send-email-linux@prisktech.co.nz>
References: <1350461444-22832-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201210171257.11924.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 October 2012, Tony Prisk wrote:
> This patch adds a simple multi_v5_defconfig for arch-vt8500
> multiplatform.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> 
> I expect there will be a bit of comment regarding this as others will
> need to add their requirements as well, and it seems overly basic.

Right now, I think we only need to add imx1 and imx2, basically
taking everything from arch/arm/configs/imx_v4_v5_defconfig.

Shawn and Sascha, let us know if you have other preferences here. 

	Arnd
