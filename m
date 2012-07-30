From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 17:28:09 +0100
Subject: [PATCH 1/6] Initial csb1724 board support (FDT)
In-Reply-To: <20120730152829.GJ18016@lunn.ch>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-2-git-send-email-ian.molton@codethink.co.uk>
 <20120730152829.GJ18016@lunn.ch>
Message-ID: <5016B619.7030602@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 16:28, Andrew Lunn wrote:
> Hi Ian
>
>> diff --git a/arch/arm/configs/csb1724_defconfig
>> b/arch/arm/configs/csb1724_defconfig new file mode 100644 index
>> 0000000..927b269 --- /dev/null +++
>> b/arch/arm/configs/csb1724_defconfig @@ -0,0 +1,47 @@
>> +CONFIG_ARCH_KIRKWOOD=y +CONFIG_ARCH_KIRKWOOD_DT=y
>> +CONFIG_MACH_CSB1724_DT=y
> Do you really need this? Its the only kirkwood board with its on
> _defconfig file. What makes this board special?

Nothing. defconfigs are just there to make configuring your kernel easy.

The kirkwood defconfig doesnt fit the currently supported hardware
set on the csb1724 very well. Why build stuff you dont need?

-Ian
