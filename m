From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 17:48:44 +0100
Subject: [PATCHv5 5/5] arm: mvebu: Add device tree for db-dxbc2 and
 db-xc3-24g4xg boards
In-Reply-To: <20170127032546.14657-6-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Fri, 27 Jan 2017 16:25:46 +1300")
References: <20170127032546.14657-1-chris.packham@alliedtelesis.co.nz>
 <20170127032546.14657-6-chris.packham@alliedtelesis.co.nz>
Message-ID: <87poj8wis3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On ven., janv. 27 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> These boards are Marvell's evaluation boards for the 98DX4251 and
> 98DX3336 SoCs.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v5:
>     - update license text
>     - use node labels
>
>  arch/arm/boot/dts/db-dxbc2.dts      | 151 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/db-xc3-24g4xg.dts | 142 +++++++++++++++++++++++++++++++++
>  2 files changed, 293 insertions(+)
>  create mode 100644 arch/arm/boot/dts/db-dxbc2.dts
>  create mode 100644 arch/arm/boot/dts/db-xc3-24g4xg.dts

I only noticed it when I applied your patch: could you rename them by
adding the prefix armada-xp-. The rule we use for naming the dts is to
start by the SoC it belongs. The main benefit is when we try to have all
the device tree file of the same SoC we just have to parse the name of
the files.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
