From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 23 Aug 2013 10:56:57 +0100
Subject: [Patch v3 2/3] ARM: dts: Document the CCI PMU DT bindings
In-Reply-To: <52168E04.5020406@wwwdotorg.org>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
 <1377183748-5717-3-git-send-email-punit.agrawal@arm.com>
 <52168E04.5020406@wwwdotorg.org>
Message-ID: <521731E9.504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 22/08/13 23:17, Stephen Warren wrote:
> On 08/22/2013 09:02 AM, Punit Agrawal wrote:
>> The CCI PMU can profile bus transactions at the master and slave
>> interfaces of the CCI. The PMU can be used to observe an aggregated
>> view of the bus traffic between the various components connected to the
>> CCI.
>>
>> Introduce a binding for the CCI PMU. The PMU node will be a sub-node of
>> the CCI node.
>
> This also seems fine to me.
> Acked-by: Stephen Warren <swarren@nvidia.com>
>

Thanks for the Ack on both the patches. I'll get these queued for either 
3.12 or if it is too late for that then 3.13.

Cheers,
Punit
