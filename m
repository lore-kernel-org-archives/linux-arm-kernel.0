From: panand@redhat.com (Pratyush Anand)
Date: Mon, 12 Jan 2015 10:20:18 +0530
Subject: [RFC 8/8] ARM64: Add uprobe support
In-Reply-To: <20150109174524.GA13161@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
 <20150108170324.GT11583@arm.com> <54AEC470.50509@redhat.com>
 <20150109174524.GA13161@redhat.com>
Message-ID: <54B3528A.6070606@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 09 January 2015 11:15 PM, Oleg Nesterov wrote:
> On 01/08, Pratyush Anand wrote:
>>
>> On Thursday 08 January 2015 10:33 PM, Will Deacon wrote:
>>>
>>> I'm assuming that means you don't support compat (AArch32) tasks with this?
>>
>> Hummm.. Yes, compat not yet supported.
>>
>> I will come back on this.
>
> I obviously do not know how difficult is to support the compat tasks, and
> in any case I leave this to you and Will.
>

I think most of the stuff can be picked from arch/arm. But I do not have 
a platform to test this feature.So, I will not be taking up as of now.

~Pratyush
