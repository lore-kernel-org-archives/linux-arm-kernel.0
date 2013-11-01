From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 1 Nov 2013 11:35:34 -0400
Subject: [PATCH 2/2] ARM: kirkwood: enable HIGHMEM in defconfig
In-Reply-To: <1383152110-19577-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1383152110-19577-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131101153534.GS26784@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 05:55:10PM +0100, Thomas Petazzoni wrote:
> The Kirkwood-based OpenBlocks A7 platform has 1 GB of memory. To make
> use of this memory completely, enabling HIGHMEM is needed, so we
> enable it by default in the kirkwood_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/kirkwood_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu-next/defconfig

thx,

Jason.
