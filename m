From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 10 Oct 2018 10:00:01 -0700
Subject: [PATCH 4/4] firmware: ti_sci: Add helper apis to mange resources
In-Reply-To: <20181006163432.z5skpgfm7oqoiuaf@akan>
References: <20181005143006.18284-1-lokeshvutla@ti.com>
 <20181005143006.18284-5-lokeshvutla@ti.com>
 <20181005201453.g3p2jhpigcvijpce@kahuna>
 <176f77cf-d295-0f37-ea9d-26f76f6d79c7@ti.com>
 <20181006163432.z5skpgfm7oqoiuaf@akan>
Message-ID: <0d559577-00a6-27d2-cb9a-64b162f58691@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

10/6/2018 9:34 AM, Nishanth Menon wrote:
> On 13:08-20181006, Lokesh Vutla wrote:
>>
>>
>> On 10/6/2018 1:44 AM, Nishanth Menon wrote:
>>> NAK. Where is the binding for this? What is this decoding? Please don't
>>> decode binding without having an official binding.
>>
>> This is a helper library for the clients to get resource range from DT
>> and is not compulsory for clients to use this library to managing these
>> resources. So in my understanding DT bindings should go into the client
>> DT doc as posted here[1].  If you really insist I can add these details
> 
> Thanks.. Please get the binding approved before we discuss
> implementation in driver.
>
Absolutely. Infact there is no rush to post driver patches before the
DT binding are approved. Lets stick to the usual flow.

Regards,
Santosh
