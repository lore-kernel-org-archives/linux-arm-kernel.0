From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jun 2012 08:14:49 +0100
Subject: [PATCH 01/14] rtc: ab8500-rtc: IRQF_ONESHOT when requesting a
 threaded IRQ
In-Reply-To: <20120613152558.e6025b04.akpm@linux-foundation.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-2-git-send-email-lee.jones@linaro.org>
 <201206111531.20468.arnd@arndb.de> <4FD70481.6020207@linaro.org>
 <20120613152558.e6025b04.akpm@linux-foundation.org>
Message-ID: <4FD98F69.3010302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/12 23:25, Andrew Morton wrote:
> On Tue, 12 Jun 2012 09:57:37 +0100
> Lee Jones<lee.jones@linaro.org>  wrote:
>
>> The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.
>
> What does this mean.  The kernel crashes?  The registration fails?  A
> warning is emitted?
>
> When fixing a bug, please fully describe the consequences of that bug.
>
>> Cc: stable at vger.kernel.org
>
> Especially when suggesting a -stable backport.

No problem. I'll try to remember that for next time.

I see that you've taken the patch into your tree however. So do you want 
me to update the commit log and resubmit, or are you going to 'let this 
one slide'?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
