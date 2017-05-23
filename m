From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 23 May 2017 16:03:24 +0200
Subject: [PATCH 0/2] ARM: dts: mvebu: dts updates for 98dx3236/98dx4251
In-Reply-To: <20170420215814.6817-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Fri, 21 Apr 2017 09:58:12 +1200")
References: <20170420215814.6817-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <87h90by8k3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On jeu., avril 20 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> A couple of minor updates for the 98dx3236 and 98dx4251.
>
> Chris Packham (2):
>   ARM: dts: mvebu: add missing interrupt to 98dx4251 switch
>   ARM: dts: mvebu: disable the rtc on 98dx3236 SoC


both patches applied on mvebu/dt

Thanks,

Gregory

>
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 4 ++++
>  arch/arm/boot/dts/armada-xp-98dx4251.dtsi | 1 +
>  2 files changed, 5 insertions(+)
>
> -- 
> 2.11.0.24.ge6920cf
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
