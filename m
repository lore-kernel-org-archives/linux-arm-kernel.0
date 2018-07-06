From: martin@lucina.net (Martin Lucina)
Date: Fri, 6 Jul 2018 16:58:13 +0200
Subject: [PATCH 03/10] arm64: dts: allwinner: a64: Olinuxino: fix DRAM
 voltage
In-Reply-To: <20180706085210.17952-4-andre.przywara@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-4-andre.przywara@arm.com>
Message-ID: <20180706145813.mwbug2yg7hnbjihy@nodbug.lucina.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, 06.07.2018 at?09:52, Andre Przywara wrote:
> The Olinuxino board uses DDR3L chips which are supposed to be driven
> with 1.35V. The reset default of the AXP is properly set to 1.36V.
> 
> While technically the chips can also run at 1.5 volts, changing the
> voltage on the fly while booting Linux is asking for trouble. Also
> running at a lower voltage saves power.
> 
> So fix the DCDC5 value to match the actual board design.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

Tested-by: Martin Lucina <martin@lucina.net>
