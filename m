From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 18 Oct 2013 10:54:59 -0700
Subject: [PATCH] ARM: OMAP1: Fix a bunch of GPIO related section warnings
 after initdata got corrected
In-Reply-To: <20131018161017.GO15154@atomide.com> (Tony Lindgren's message of
 "Fri, 18 Oct 2013 09:10:18 -0700")
References: <20131018160358.GL15154@atomide.com>
 <20131018161017.GO15154@atomide.com>
Message-ID: <87vc0uv4zw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [131018 09:04]:
>> From: Tony Lindgren <tony@atomide.com>
>> Date: Fri, 18 Oct 2013 08:54:16 -0700
>> Subject: [PATCH] ARM: OMAP1: Fix a bunch of GPIO related section warnings after initdata got corrected
>
> Oops, sorry duplicate header. Below is a clean version that
> should apply with git am --scissors.
>  
>> Arnd, Kevin, Olof, want to apply this directly on top of the fixes
>> I sent earlier?

Yup, I've applied this version to fixes-non-critical on top of your
other series. 

Thanks for the quick fix, and nice to see at least someone besides me
and Olof are looking at the automated build/boot output. :)

Kevin
