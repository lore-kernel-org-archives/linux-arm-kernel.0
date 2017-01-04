From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 4 Jan 2017 14:30:50 -0800
Subject: [PATCHv6 00/11] CONFIG_DEBUG_VIRTUAL for arm64
In-Reply-To: <20170104114449.GA18193@arm.com>
References: <1483464113-1587-1-git-send-email-labbott@redhat.com>
 <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
 <b3de65da-8a74-2510-268e-34516cc2de77@redhat.com>
 <20170104114449.GA18193@arm.com>
Message-ID: <e13dc77e-6709-8122-9856-35aee876b836@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2017 03:44 AM, Will Deacon wrote:
> On Tue, Jan 03, 2017 at 03:25:53PM -0800, Laura Abbott wrote:
>> On 01/03/2017 02:56 PM, Florian Fainelli wrote:
>>> On 01/03/2017 09:21 AM, Laura Abbott wrote:
>>>> Happy New Year!
>>>>
>>>> This is a very minor rebase from v5. It only moves a few headers around.
>>>> I think this series should be ready to be queued up for 4.11.
>>>
>>> FWIW:
>>>
>>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>>>
>>
>> Thanks!
>>
>>> How do we get this series included? I would like to get the ARM 32-bit
>>> counterpart included as well (will resubmit rebased shortly), but I have
>>> no clue which tree this should be going through.
>>>
>>
>> I was assuming this would go through the arm64 tree unless Catalin/Will
>> have an objection to that.
> 
> Yup, I was planning to pick it up for 4.11.
> 
> Florian -- does your series depend on this? If so, then I'll need to
> co-ordinate with Russell (probably via a shared branch that we both pull)
> if you're aiming for 4.11 too.

Yes, pretty much everything in Laura's patch series is relevant, except
the arm64 bits.

I will get v6 out now addressing Laura's and Hartley's feedback and
then, if you could holler when and where you have applied these, I can
coordinate with Russell about how to get these included.

Thanks and happy new year!
-- 
Florian
