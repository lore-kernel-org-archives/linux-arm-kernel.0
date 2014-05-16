From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 May 2014 16:08:53 -0700
Subject: [PATCHv4 15/20] ARM: configs: enable XHCI mvebu support in
 multi_v7_defconfig
In-Reply-To: <1399470746-2948-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399470746-2948-16-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140516230853.GA6423@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 03:52:21PM +0200, Thomas Petazzoni wrote:
> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
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

Applied.


-Olof
