From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 21:59:46 -0500
Subject: [PATCH] ARM: mvebu: add MTD_BLOCK to mvebu_v7_defconfig
In-Reply-To: <1415873489-22446-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415873489-22446-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141122025946.GR22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 11:11:29AM +0100, Thomas Petazzoni wrote:
> Since many (most?) mvebu platforms have NAND or SPI flashes, it makes
> sense to have CONFIG_MTD_BLOCK=y in mvebu_v7_defconfig. The vast
> majority of the other ARM defconfigs have it enabled, including
> mvebu_v5_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Patch based on mvebu/defconfig
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/defconfig with Andrew's Ack.

thx,

Jason.
