From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 20 Feb 2014 11:51:41 +0200
Subject: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
In-Reply-To: <53050573.8090506@epfl.ch>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
 <5304DA2C.3030605@ti.com> <53050573.8090506@epfl.ch>
Message-ID: <5305D02D.5020702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2014 09:26 PM, Florian Vaussard wrote:
>
> On 02/19/2014 05:22 PM, Tero Kristo wrote:
>> On 02/19/2014 11:15 AM, Florian Vaussard wrote:
>>> Hello,
>>>
>>> Trying to get my SMSC9221 working on OMAP4 with DT,
>>> I faced a misconfigured gpmc_fck (dummy clock set to 0)
>>> resulting in serveral division-by-zero, misconfigured
>>> timings and driver lost in the La La Land.
>>>
>>> To solve this, patch 1 removes gpmc_fck from the dummy
>>> clocks, and patch 2 adds the gpmc_fck DT node and
>>> reference it from the gpmc node.
>>>
>>> Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.
>>
>> I can't test GPMC myself, but other than that, this set looks good to go.
>>
>
> Thank you. Would you like more test coverage by other people? I would
> like to see this in -rc if possible, as it is needed to boot my OMAP4
> system.

Well, I just think the driver clock change should be acked by someone 
who knows gpmc better than me.

-Tero
