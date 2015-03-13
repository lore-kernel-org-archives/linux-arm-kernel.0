From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Mar 2015 22:26:59 +0100
Subject: [PATCH 0/6] ARM: cpuidle: Unify the ARM64/ARM DT approach
In-Reply-To: <20150313182908.GU30671@e104818-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <5501A1DE.9020804@linaro.org>
 <20150313182908.GU30671@e104818-lin.cambridge.arm.com>
Message-ID: <55035623.8010002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2015 07:29 PM, Catalin Marinas wrote:
> On Thu, Mar 12, 2015 at 03:25:34PM +0100, Daniel Lezcano wrote:
>> do you agree with this patchset ?
>
> In principle yes, apart from some function naming and I'm waiting for
> Lorenzo's ack as well. Do you plan to upstream this directly via your
> tree? If yes, I'll look in more detail and give some acks.

If you don't care, I would like to upstream via my tree because there is 
a couple of operations (like sharing a branch) I would like to monitor 
to let people build their driver on top of it: renesas and qcom.

Qcom's cpuidle driver is already implemented and waits for this patchset 
to be upstream (the patchset has been around long enough). And I believe 
the Renesas driver will be reworked to use it also.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
