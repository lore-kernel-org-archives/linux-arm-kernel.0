From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 18 Nov 2015 08:10:28 -0600
Subject: [PATCHv3 0/7] arm64: Use contiguous PTE bit for the kernel linear
 mapping
In-Reply-To: <20151118110124.GF22731@arm.com>
References: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
 <20151009125052.GV17192@e104818-lin.cambridge.arm.com>
 <5617D67E.8080607@arm.com> <564B49B4.8000204@arm.com>
 <20151118110124.GF22731@arm.com>
Message-ID: <564C86D4.9040602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 05:01 AM, Will Deacon wrote:
> On Tue, Nov 17, 2015 at 09:37:24AM -0600, Jeremy Linton wrote:
>> Hello,
>
> Hi Jeremy,
>
>> 	Just a heads up, but this patch is causing a boot problem on a m400. I
>> should know more soon.
>
> Any chance you could share a reproducer/panic log/debug info, please?
> If we can't fix this soon, then we'll have to look at reverting the change,
> so getting a few more eyes on the problem might help.

	Its usually just hangs although, once in a while it will generate an 
unknown exception. I posted a patch last night which fixes it with a big 
hammer (extra tlb flush), but It doesn't appear to have made the mailing 
list (I regularly get relay rejected messages). I will attempt to 
re-post it again.
