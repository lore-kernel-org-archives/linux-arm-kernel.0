From: mmarek@suse.com (Michal Marek)
Date: Fri, 10 Mar 2017 22:20:43 +0100
Subject: [PATCH 1/6] arm64: Use full path in KBUILD_IMAGE definition
In-Reply-To: <20170310175854.GE18894@arm.com>
References: <20161122213434.14788-1-mmarek@suse.com>
 <20170310175854.GE18894@arm.com>
Message-ID: <ba676afc-d52c-5f79-1794-2b751054bf53@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 10.3.2017 v 18:58 Will Deacon napsal(a):
> Hi Michael,
> 
> On Tue, Nov 22, 2016 at 10:34:29PM +0100, Michal Marek wrote:
>> The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
>> expect it to point to the image file in the build directory. The
>> builddeb script has a workaround for architectures which only provide
>> the basename, but let's provide a clean interface for packaging tools.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Michal Marek <mmarek@suse.com>
>> ---
>>  arch/arm64/Makefile | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> What's the plan for this patch? I'm happy to merge it,

Great, please merge it.


> but I don't see
> the rest of the series queued anywhere.

I'll see what remains and submit the rest via the kbuild tree.

Thanks,
Michal
