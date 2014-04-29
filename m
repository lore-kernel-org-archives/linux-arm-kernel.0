From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 29 Apr 2014 07:56:20 -0700
Subject: [PATCH v2 00/10] arm64: UEFI support
In-Reply-To: <20140429144713.GL26088@console-pimps.org>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
 <20140429102817.GE17007@arm.com> <20140429114356.GK26088@console-pimps.org>
 <20140429134726.GH17007@arm.com> <20140429144713.GL26088@console-pimps.org>
Message-ID: <535FBD94.9040101@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 07:47 AM, Matt Fleming wrote:
> On Tue, 29 Apr, at 02:47:28PM, Catalin Marinas wrote:
>>
>> Waiting for the tip/x86/efi to be merged first is not a problem. We
>> also need a stable base for testing the arm64 UEFI series, so I assume
>> this series can be based onto tip/x86/efi (would such branch be rebased
>> before hitting mainline?).
>  
> tip/x86/efi is unlikely to be rebased. Certainly with dependencies like
> this there would have to be a really good reason to rebase it.
> 
>> Given that Leif's series contains both generic efi and arm64 patches,
>> what's your preference for merging them? I'm happy to add my ack and
>> they go via your tree (or the other way around).
> 
> I'm happy either way, though if I take them through my tree (and
> subsequently through tip) you won't have to worry about the merge window
> rigmarole, which is a plus.
> 
> So, eveyone happy for me to take these with Catalin's Acked-by?
> 

I'm wondering if it would be better to organize it into a separate topic
branch.  We can still take it through tip, if you want, but it would be
better than putting it all into one tree.

	-hpa
