From: panand@redhat.com (Pratyush Anand)
Date: Thu, 08 Jan 2015 23:09:03 +0530
Subject: [RFC 2/8] ARM64: Refactor kprobes-arm64
In-Reply-To: <20150108173600.GW11583@arm.com>
References: <cover.1420038188.git.panand@redhat.com>
 <9a86c217f387f45568c18b724024b0d3e040d2c6.1420038188.git.panand@redhat.com>
 <20150108165557.GQ11583@arm.com> <54AEBF54.7000704@redhat.com>
 <20150108173600.GW11583@arm.com>
Message-ID: <54AEC0B7.5060509@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 08 January 2015 11:06 PM, Will Deacon wrote:
> On Thu, Jan 08, 2015 at 05:33:08PM +0000, Pratyush Anand wrote:
>> On Thursday 08 January 2015 10:25 PM, Will Deacon wrote:
>>> On Wed, Dec 31, 2014 at 03:21:18PM +0000, Pratyush Anand wrote:
>>>> Most of the stuff of kprobes-arm64.c can also be used by uprobes.c. So
>>>> move all those part to common code area. In the process rename kprobe to
>>>> probe whereever possible.
>>>>
>>>> No functional change.
>>>
>>> In which case, can you merge this into the kprobes series (which we haven't
>>> merged yet)?
>>>
>>
>> Yes, thats why these are just RFCs. I will send next version of uprobe
>> only after kprobe patches are accepted into maintainer's tree.
>
> Ok, but it also makes sense to make kprobes refactoring changes *before* the
> patches are merged, as that reduces churn in mainline whilst you don't have
> any other dependencies.
>

Sure, Sure.. I too expect first two patches to be merged with kprobe 
series. I just did that to develop my uprobe code.

~Pratyush

> Will
>
