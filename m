From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 15:07:52 -0400
Subject: [PATCH v6 14/17] ARM: mvebu: add Device Tree description of
 xHCI controllers on Armada 38x
In-Reply-To: <1400149062-32661-15-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
 <1400149062-32661-15-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140516190752.GP27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 12:17:39PM +0200, Gregory CLEMENT wrote:
> The Marvell Armada 38x SoCs contains two xHCI controllers. This commit
> adds the Device Tree description of those interfaces at the SoC level,
> and also enables the two USB3 ports on the Armada 385 DB platform and
> one USB3 port on the Armada 385 RD platform.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-385-db.dts |  8 ++++++++
>  arch/arm/boot/dts/armada-385-rd.dts |  4 ++++
>  arch/arm/boot/dts/armada-38x.dtsi   | 17 +++++++++++++++++
>  3 files changed, 29 insertions(+)

Patches 14 through 17 applied to mvebu/dt.  Patch 17 amended as Sergei
suggested.

thx,

Jason.
