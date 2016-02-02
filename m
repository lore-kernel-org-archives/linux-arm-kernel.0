From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Tue, 2 Feb 2016 15:39:11 -0600
Subject: [RFC PATCH 0/3] arm64 initrd mapping/relocation
In-Reply-To: <20160202180622.GP10166@arm.com>
References: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160202180622.GP10166@arm.com>
Message-ID: <56B121FF.8040707@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2016 12:06 PM, Will Deacon wrote:
> On Tue, Feb 02, 2016 at 06:56:39PM +0100, Ard Biesheuvel wrote:
>> After discussing in linux-efi with Mark, and on #armlinux with Will, this is
>> a proposal for dealing with initrd memory that is potentially not covered by
>> the linear region.
>>
>> Note that this will look slightly differently when some of the KASLR work gets
>> merged, but this should only affect the way we deal with the initrd if it sits
>> outside of the linear region.
>>
>> Mostly intended for discussion, not tested at all.
>
> Thanks Ard, this looks like a much better approach to me. Mark -- does
> the general idea work for you too?

I'm not quite the right Mark but Mark Salter is on vacation
and I was the one who discovered this bug. These patches
do fix the problem and it looks like they tidy up some
code. Will they be in v4.5-rc3?

--Mark Langsdorf
