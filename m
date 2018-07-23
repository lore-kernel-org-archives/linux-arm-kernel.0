From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 23 Jul 2018 10:42:47 -0700
Subject: [PATCH V2 0/2] firmware: ti_sci: Add host-id as an optional
 parameter
In-Reply-To: <20180723133303.ijekyffgnmesrhhv@kahuna>
References: <20180716171328.11674-1-nm@ti.com>
 <20180723133303.ijekyffgnmesrhhv@kahuna>
Message-ID: <ea7691ab-db22-bea0-9753-b7a2765a22b8@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/23/2018 6:33 AM, Nishanth Menon wrote:
> On 17:13-20180716, Nishanth Menon wrote:
>> Please find attached series to enable host-id as an optional dt property.
>>
>> This is a minor update to V1 -> Mostly to pick up Greet's feedback and Rob's Ack.
>>
>> V1: https://patchwork.ozlabs.org/cover/931822/
>>
>> The series is based on v4.18-rc1 and is available here:
>> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-tisci
>>
>> Consolidated all patches (including all series) are available here:
>> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ
>>
>> Full Boot log (integrated of all series for AM654) is available here:
>>     https://pastebin.ubuntu.com/p/bBFmnzYtCd/
>>
>> Nishanth Menon (2):
>>    Documentation: dt: keystone: ti-sci: Add optional host-id parameter
>>    firmware: ti_sci: Provide host-id as an optional dt parameter
>>
>>   .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
>>   drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
>>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> Santosh,
> 
> Apologies, I see you have already send your PR for v4.19. Was
> just wondering if this is something we can consider for rc
> cycle OR if you'd consider a followup PR for the same.
> 
NP. Patch(s) doesn't look RC material so don't plan to send
it as part of RC. Please let me know if its o.w

This will have to wait for next cycle. Will merge this
early once v4.19-rc1 comes out.

Regards,
Santosh
