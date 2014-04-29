From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 29 Apr 2014 07:36:24 -0700
Subject: [PATCH v2 00/10] arm64: UEFI support
In-Reply-To: <20140429114356.GK26088@console-pimps.org>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
 <20140429102817.GE17007@arm.com> <20140429114356.GK26088@console-pimps.org>
Message-ID: <535FB8E8.1060905@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 04:43 AM, Matt Fleming wrote:
> (Pulling in Peter and Stephen)
> 
> On Tue, 29 Apr, at 11:28:17AM, Catalin Marinas wrote:
>>
>> The patches look fine to me, they've been through several rounds of
>> review already. How do we propose these get merged as the series
>> contains both generic and arm64 patches? And there are dependencies
>> already in linux-next.
>>
>> Are the EFI patches in -next pulled from some non-rebaseable branch?
> 
> Peter suggsted a plan when he took the generic EFI stuff that's in tip
> (and hence currently in linux-next),
> 
>   It doesn't hurt to inform Stephen, although I think it will simply fall
>   out automatically since he uses git to merge and git will recognize the
>   graph.
> 
>   During the merge window, it means they should not push their patches
>   until Linus has accepted the precondition patches from the tip tree.
>   Since Ingo and I try to push most of the tip tree as early as possible
>   in the merge window, this is usually not a problem.
> 
> So we currently have the prerequisites in tip/x86/efi, and assuming that
> this 10-patch series gets merged into a single branch somewhere, things
> should work automatically for linux-next.
> 
> It may be prudent to negotiate a plan now for when the merge window
> opens because, as Peter mentions above, the stuff in tip/x86/efi needs
> to be merged by Linus first to avoid build breakage with the arm64
> stuff.

Whomever is going to push the arm64 stuff just needs to be aware of this
constraint.  Again, since we tend to push -tip very early in the merge
window, unless there are problems or late additions, this is unlikely to
be a problem in any way.

	-hpa
