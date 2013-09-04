From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 04 Sep 2013 13:26:17 +0100
Subject: [Patch v3 2/3] ARM: dts: Document the CCI PMU DT bindings
In-Reply-To: <938AAABA-BE7E-48ED-82D6-61A35B6D9774@codeaurora.org>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
 <1377183748-5717-3-git-send-email-punit.agrawal@arm.com>
 <938AAABA-BE7E-48ED-82D6-61A35B6D9774@codeaurora.org>
Message-ID: <522726E9.8050406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding Will, as these patches will be going via his tree.)

Hi Will,

On 30/08/13 17:17, Kumar Gala wrote:
>
> On Aug 22, 2013, at 10:02 AM, Punit Agrawal wrote:
>
>> The CCI PMU can profile bus transactions at the master and slave
>> interfaces of the CCI. The PMU can be used to observe an aggregated
>> view of the bus traffic between the various components connected to the
>> CCI.
>>
>> Introduce a binding for the CCI PMU. The PMU node will be a sub-node of
>> the CCI node.
>>
>> Cc: devicetree at vger.kernel.org
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>> Documentation/devicetree/bindings/arm/cci.txt |   46 +++++++++++++++++++++++++
>> 1 file changed, 46 insertions(+)
>
> Acked-by: Kumar Gala <galak@codeaurora.org>
>

Can you pick Kumar's ack for the second patch before you send a pull 
request for the CCI PMU patches? Let me know if you prefer for me to 
post patches with the Acks applied.

Cheers,
Punit

> - k
>
