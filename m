From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 5 Oct 2015 13:22:12 -0500
Subject: [PATCHv2 0/7] arm64: Use contiguous PTE bit for the kernel linear
 mapping
In-Reply-To: <20151005170310.GC5557@MBP.local>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
 <20151005170310.GC5557@MBP.local>
Message-ID: <5612BFD4.6060804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2015 12:03 PM, Catalin Marinas wrote:
> On Fri, Oct 02, 2015 at 03:47:38PM -0500, Jeremy Linton wrote:
>> Also, continuing thanks to Steve Capper who has been religiously
>> testing these patch sets, and found a bug in the previous
>> implementation.
>
> Quick question: has this series been tested with CONFIG_DEBUG_RODATA
> enabled?

In my case, yes. Longer answer, my testing was pretty basic. I flipped 
it on and checked to see if the machine booted and if the kernel 
mappings looked correct.
