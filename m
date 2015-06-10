From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Jun 2015 10:20:21 +0100
Subject: [PATCH] arm64: dts: add device tree for ARM SMM-A53x2 on LogicTile
 Express 20MG
In-Reply-To: <20150610085825.GS12807@e106497-lin.cambridge.arm.com>
References: <1433864311-2326-1-git-send-email-kristina.martsenko@arm.com>
 <20150610085825.GS12807@e106497-lin.cambridge.arm.com>
Message-ID: <55780155.9000903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 10/06/15 09:58, Liviu Dudau wrote:
> Hi Kristina,
> 
> On Tue, Jun 09, 2015 at 04:38:31PM +0100, Kristina Martsenko wrote:
>> Add a DTS file for the MP2 Cortex-A53 Soft Macrocell Model implemented
>> on a LogicTile Express 20MG (V2F-1XV7) daughterboard. This is based on
>> the version that's currently available from the ARM DTS repository [1].
>>
>> [1] git://linux-arm.org/arm-dts.git

[...]

>> +
>> +		/include/ "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi"
> 
> Patch looks OK to me even if I'm not too keen on including DTSi files from
> a "different" arch directory.

Well, we do that for the code as well (see how KVM is build on all
architectures). I agree that this is not very nice, but so far the
alternative (symbolic links) is a lot worse.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
