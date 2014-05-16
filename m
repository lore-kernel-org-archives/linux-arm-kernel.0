From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 01:41:09 -0400
Subject: [PATCH v6 12/17] ARM: configs: enable XHCI mvebu support in
 mvebu_v7_defconfig
In-Reply-To: <1400149062-32661-13-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
 <1400149062-32661-13-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140516054109.GD27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 12:17:37PM +0200, Gregory CLEMENT wrote:
> The Marvell Armada 38x platform needs the xhci_mvebu driver enabled
> for the xHCI USB hosts, so this commit enables the corresponding
> Kconfig option in mvebu_v7_defconfig.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/defconfig

thx,

Jason.
