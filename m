From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 9 Feb 2016 17:35:34 -0600
Subject: [PATCH V2 08/12] dtb: amd: Add PERF CCN-504 device tree node
In-Reply-To: <3090961.S0JY5ma2pB@wuerfel>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1454954357-8395-9-git-send-email-Suravee.Suthikulpanit@amd.com>
 <3090961.S0JY5ma2pB@wuerfel>
Message-ID: <56BA77C6.6020803@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/09/2016 08:58 AM, Arnd Bergmann wrote:
> On Monday 08 February 2016 11:59:13 Suravee Suthikulpanit wrote:
>> +               /* Perf CCN504 PMU */
>> +               ccn: ccn at 0xe8000000 {
>>
>
> The address is wrong, please remove the '0x'.
>
> 	Arnd
>

Right, thanks for catching this.

Suravee
