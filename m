From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 20 Nov 2015 17:51:22 +0800
Subject: [PATCH 0/2] Add I2C support for Marvell Berlin BG4CT
In-Reply-To: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
References: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
Message-ID: <20151120175122.7b79e83c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 20 Nov 2015 17:46:59 +0800
Jisheng Zhang wrote:

> The first patch adds i2c nodes in the soc's dtsi, the second patch
> enables all i2c nodes for BG4CT STB board.
> 
> NOTE: this series depends on the missed-in-v4.4rc1 patches:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378634.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378635.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378638.html

also depends on BG4CT clk support:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386760.html

I just want to sent out for review early so that i2c support will get merged
once clk patches are accepted and merged.

Thanks,
Jisheng

> 
> Jisheng Zhang (2):
>   arm64: dts: berlin4ct: add I2C nodes for BG4CT
>   arm64: dts: berlin4ct: enable all i2c nodes for the STB board
> 
>  arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 50 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 52 +++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
