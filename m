From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Nov 2010 10:11:35 +0000
Subject: [PATCH v2 02/20] ARM: LPAE: Factor out 2-level page table
	definitions into separate files
In-Reply-To: <20101116100406.GB12891@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-3-git-send-email-catalin.marinas@arm.com>
	<20101115233129.GG31421@n2100.arm.linux.org.uk>
	<AANLkTikrz+yM6idm-aij10vsKZMVSOBfZSdeEJbDRwiC@mail.gmail.com>
	<20101116100406.GB12891@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=AGUs0nQPK0nx52m1XA8nx2sRmQcxicuG-Kd-D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2010 10:04, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 16, 2010 at 09:14:52AM +0000, Catalin Marinas wrote:
>> > Of couse, I now have patches for this and my other points... will sort
>> > them out into a series in the next few days.
>>
>> Thanks.
>
> BTW, don't post another round of patches just because you've had _some_
> comments back - your v2 patches are still being looked through, your v3
> patches haven't even been looked at yet.

I'll wait for your patches on the PTE offset and than rebase mine on
top. It may be sometime next week as I already have a lot to do.

I posted the v3 patches just to clarify the issues around the 3/20
patch. The other patches are pretty much the same, so you can skip
this version and wait for v4.

-- 
Catalin
