From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 May 2014 09:32:58 -0400
Subject: [PATCH v6 13/17] ARM: configs: enable XHCI mvebu support in
 multi_v7_defconfig
In-Reply-To: <1400149062-32661-14-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
 <1400149062-32661-14-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140515133258.GM27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 12:17:38PM +0200, Gregory CLEMENT wrote:
> The Marvell Armada 38x platform needs the xhci_mvebu driver enabled
> for the xHCI USB hosts, so this commit enables the corresponding
> Kconfig option in multi_v7_defconfig.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: arm at kernel.org
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
