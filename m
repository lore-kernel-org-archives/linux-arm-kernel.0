From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 20:28:30 -0400
Subject: [PATCHv3 4/5] ARM: configs: add ahci_mvebu to mvebu_v7_defconfig
In-Reply-To: <1397574006-5868-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140426002830.GN28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:00:05PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 38x platform needs the ahci_mvebu driver enabled
> for the AHCI interfaces, so this commit enables the corresponding
> Kconfig option in mvebu_v7_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/defconfig

thx,

Jason.
