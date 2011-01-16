From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 16 Jan 2011 12:03:33 -0800
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd
	and phychan structures
In-Reply-To: <20110116195948.GA4864@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
	<E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
	<AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
	<20110115092324.GX15996@n2100.arm.linux.org.uk>
	<AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
	<20110116123615.GC27542@n2100.arm.linux.org.uk>
	<AANLkTi=s-CQVEj4wOZo8cCbzWnj5G0p_COtKoQt7Xzy8@mail.gmail.com>
	<20110116195948.GA4864@n2100.arm.linux.org.uk>
Message-ID: <4D334F15.3080705@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/16/2011 11:59 AM, Russell King - ARM Linux wrote:
> On Sun, Jan 16, 2011 at 11:56:08AM -0800, Dan Williams wrote:
>>   On Sun, Jan 16, 2011 at 4:36 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk>  wrote:
>>>>> That probably means you've got something out of order.  I have them
>>>>> ordered in my git tree, I'll recheck there.
>>>>
>>>> I rechecked here and I think everything is in order.
>>>
>>> Okay, something's screwed in the patch set - and I think I see what it is.
>>> Patch 16 is missing a change.  I'll respin.
>>
>>   Can this be incremental to the previous series instead?  I'm looking
>> to get my 2.6.38 pull request submitted.
>
> In which case I don't know what state your tree in, so...

Sorry, should have pointed that out, here it is:

git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next

--
Dan
