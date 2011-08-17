From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Aug 2011 09:08:38 -0500
Subject: [PATCH 1/6] ARM: highbank: add devicetree source
In-Reply-To: <4e4b8979.533fd80a.2ff3.1626SMTPIN_ADDED@mx.google.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-2-git-send-email-robherring2@gmail.com>
	<4e4b8979.533fd80a.2ff3.1626SMTPIN_ADDED@mx.google.com>
Message-ID: <4E4BCB66.3070607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 08/17/2011 04:27 AM, Mark Rutland wrote:
> Hi Rob,
> 
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
>> kernel-bounces at lists.infradead.org] On Behalf Of Rob Herring
>> Sent: 16 August 2011 21:35
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: Rob Herring
>> Subject: [PATCH 1/6] ARM: highbank: add devicetree source
>>
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds the devicetree source and documentation for the Calxeda
>> highbank
>> platform.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
>>  arch/arm/boot/dts/highbank.dts                    |  212
>> +++++++++++++++++++++
>>  2 files changed, 220 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
>>  create mode 100644 arch/arm/boot/dts/highbank.dts
> 
> ...
> 
>> +		L2: l2-cache {
>> +			compatible = "arm,pl310-cache";
>> +			reg = <0xfff12000 0x1000>;
>> +			interrupts = <102>;
>> +			cache-unified;
>> +			cache-level = <2>;
>> +		};
> 
> Currently, the binding documentation sitting in Russell's for-next branch
> doesn't have the interrupts property we discussed previously:
> http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-August/007301.html
> 
> I posted a patch to add it to the documentation, but no-one responded:
> http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-August/007349.html
> 
> Can I take your use of the property as an ack?
> 
Yes, sorry forgot about it.

Acked-by: Rob Herring <rob.herring@calxeda.com>


> How do we get this merged?

Add to Russell's patch system or perhaps in Will's tree.

Rob
