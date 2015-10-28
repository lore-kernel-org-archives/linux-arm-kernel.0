From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 28 Oct 2015 20:10:47 +0100
Subject: [PATCH 3/3] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <5630DA81.4030301@broadcom.com>
References: <1444844820-24290-1-git-send-email-kapilh@broadcom.com>
 <1444844820-24290-4-git-send-email-kapilh@broadcom.com>
 <561ED691.8080407@hauke-m.de> <561FD005.3040900@broadcom.com>
 <562016A9.7050208@hauke-m.de> <20151015211703.GQ32089@broadcom.com>
 <5630DA81.4030301@broadcom.com>
Message-ID: <56311DB7.5000905@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2015 03:24 PM, Kapil Hali wrote:
> 
> 
> On 10/16/2015 2:47 AM, Jon Mason wrote:
>> On Thu, Oct 15, 2015 at 11:12:09PM +0200, Hauke Mehrtens wrote:
>>> On 10/15/2015 06:10 PM, Kapil Hali wrote:
>>>>
>>>>
>>>> On 10/15/2015 3:56 AM, Hauke Mehrtens wrote:
>>>>> On 10/14/2015 07:47 PM, Kapil Hali wrote:
>>>>>> Add SMP support for Broadcom's Northstar Plus SoC,
>>>>>> cpu enable method and pen_release procedures. This
>>>>>> changes also consolidates iProc family's - BCM NSP
>>>>>> and BCM Kona, SMP handling in a common file.
>>>>>
>>>>> This will probably also work on normal Northstar CPUs without changes.
>>>>>
>>>> I think, it should work for most of the variants of Northstar family, 
>>>> except for those which have a BOOTROM bug.
>>>
>>> Which SoC are affected by this BOOTROM bug?
>>
>> 53012 is the one I am seeing.  Not seeing it on 4708 (and assuming it is
>> not present on 4709).  Internally, we do the ugly bug workaround on
>> all Northstar SoCs.  The workaround is not acceptable upstream, so I
>> am not pushing it. :)
>>
>> Thanks,
>> Jon
>>
> 
> Hi Hauke,
> 
> Now that you have tested Jon's patch which is based on my changes for
> SMP, shall I take his changes and add it on top of my changes and resend?
> Also, do I consider your Acked-by and Tested-by for the change?
> 
> Thanks,
> Kapil
> 

Hi Kapil,

I tested this on Northstar 1.

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Tested-by: Hauke Mehrtens <hauke@hauke-m.de>

I think Florian has to take the patches and you should hurry up because
the merge window probably opens on Monday.

You can send all patches again with the bcm501x patch or just that one,
I assume there are no changes needed for the other patches?

Hauke
