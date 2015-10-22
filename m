From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 09:38:42 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: improve multi_v7_defconfig
 support for Berlin
In-Reply-To: <1444831370-25688-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444831370-25688-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20151022163842.GA17556@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 04:02:50PM +0200, Antoine Tenart wrote:
> Some drivers used on a Marvell Berlin kernel were missing from
> multi_v7_defconfig. This series add them:
> 
>   * The pxa168 Ethernet driver is added as a loadable module.
>   * The Berlin ADC driver is added as a loadable module.
>   * Both the Berlin USB PHY and SATA PHY drivers are added,
>     built-in, as they are required for the already available USB
>     and SATA functionalities in multi_v7_defconfig.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
> 
> Hi,
> 
> That's actually a v2 of the series "ARM: berlin: improve multi_v7_defconfig
> support" I sent earlier. I've squashed all 4 commits into a single one and
> updated to use loadable modules when possible in this v2.
> 
> Antoine

Applied, thanks!


-Olof
