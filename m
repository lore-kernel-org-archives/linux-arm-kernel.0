From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 17 Aug 2011 14:37:58 +0100
Subject: [PATCH 1/3] ARM: Make cpu_alignment into a global variable
In-Reply-To: <4E4BA689.5010100@ru.mvista.com>
References: <1313504053-27873-1-git-send-email-dave.martin@linaro.org>
	<1313504053-27873-2-git-send-email-dave.martin@linaro.org>
	<4E4BA689.5010100@ru.mvista.com>
Message-ID: <20110817133758.GA2861@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 03:31:21PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 16-08-2011 18:14, Dave Martin wrote:
> 
> >The CPU architecture really should not be changing at runtime, so
> >make it a global variable instead of a function.
> 
> >The cpu_architecture() function in<asm/system.h>  remains the
> >correct way to read this variable from C code.
> 
> >Signed-off-by: Dave Martin<dave.martin@linaro.org>
> 
>    You're talking of the CPU architecture here but the subject has
> "cpu_alignment"...

Hmmm, I guess my brain was on autopilot when I wrote that...

You're right, it should say cpu_architecture in the subject.
I'll fix this before I repost.

Thanks
---Dave
