From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Sep 2014 14:24:22 +0200
Subject: [PATCH v3] ARM: dts: add CPU nodes for Exynos4 SoCs
In-Reply-To: <20140925093605.GA23853@e102568-lin.cambridge.arm.com>
References: <5230569.XLlNbB5NvF@amdc1032>
 <018e01cfd885$770dd940$65298bc0$@kernel.org>
 <20140925081704.GA20841@e102568-lin.cambridge.arm.com>
 <5423DA0D.9030100@linaro.org>
 <20140925093605.GA23853@e102568-lin.cambridge.arm.com>
Message-ID: <54240976.5080605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2014 11:36 AM, Lorenzo Pieralisi wrote:
> On Thu, Sep 25, 2014 at 10:02:05AM +0100, Daniel Lezcano wrote:
>> On 09/25/2014 10:17 AM, Lorenzo Pieralisi wrote:
>>> [CC'ed Daniel to make him aware this patch goes through your tree]
>>
>> Thanks for the head up. I was about to send the PR to Rafael.
>>
>> [ ... ]
>>
>>> That's great, now my Exynos CPUidle DT patch should be rebased on top
>>> of this patch so that thanks to the testing carried out by Bart it can be
>>> merged too.
>>
>> Ok, I am getting confused. How can I rebase the latest patch of your
>> series with a patch no yet available in my tree ?
>
> I just wanted to say that the Exynos CPUidle DT patch depends on this
> patch, that is now going through Samsung tree, to make sure we are on
> the same page and prevent issues, it was not clear, sorry.

Ah, ok.

>> I propose just to drop the last patch and wait for the next merge to
>> reintegrate it into the cpuidle tree. Does it make sense ?
>
> I agree, drop the Exynos CPUidle DT patch, we will reintegrate it in the
> CPUidle tree when the merge window closes and dependencies are sorted out.

Perfect. I sent the PR to Rafael.

Thanks

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
