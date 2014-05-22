From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 10:23:13 -0400
Subject: [PATCH] ARM: mvebu: enable MSI support in mvebu_v7_defconfig
In-Reply-To: <1400598964-2062-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400598964-2062-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140522142313.GP8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:16:04PM +0200, Thomas Petazzoni wrote:
> Since Armada 370, XP, 375 and 38x have PCI MSI support, it makes sense
> to enable CONFIG_PCI_MSI in mvebu_v7_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Applies on top of mvebu/defconfig
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/defconfig

thx,

Jason.
