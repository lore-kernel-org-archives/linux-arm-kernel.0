From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Oct 2014 10:54:59 -0700
Subject: [PATCH v2 2/3] ARM: vfp: Fix VFPv3 hwcap detection on CPUID
 based cpus
In-Reply-To: <20141028121154.GA12136@arm.com>
References: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
 <1413294539-22069-3-git-send-email-sboyd@codeaurora.org>
 <20141027103118.GA8768@arm.com> <544EA212.7030401@codeaurora.org>
 <20141028121154.GA12136@arm.com>
Message-ID: <20141028175459.GE12469@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28, Will Deacon wrote:
> 
> Sure. There's a spelling mistake ("arhitecture") which you should fix,
> but the code looks ok.

Ok I'll fix it up and send it off to the patch tracker if I don't
hear anything else.

> > 
> > I have an RFC for the undef handler written up, except for the
> > big/little thing. Let me post it. Is there anyone from the userspace
> > side that can be on Cc?
> 
> Off the top of my head:
> 
>   Mans Rullgard (already replied to this thread)
>   Peter Maydell <peter.maydell@linaro.org> [QEMU]
>   Jacob Bramley <jacob.bramley@arm.com> [JITs]
>   Kyrylo Tkachov <kyrylo.tkachov@arm.com> [GCC]
> 

Thanks. I'll add them to the patch for next round and add them on
Cc for the current patch on the list.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
