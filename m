From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 29 Aug 2013 11:13:42 +0200
Subject: [GIT PULL] ARM: TC2: CPU idle big.LITTLE driver
In-Reply-To: <20130828183624.GH8607@quad.lixom.net>
References: <20130812153422.GA6426@e102568-lin.cambridge.arm.com>
 <20130825090848.GA12256@e102568-lin.cambridge.arm.com>
 <20130828183624.GH8607@quad.lixom.net>
Message-ID: <521F10C6.3000409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2013 08:36 PM, Olof Johansson wrote:
> On Sun, Aug 25, 2013 at 10:08:48AM +0100, Lorenzo Pieralisi wrote:
>> Hi Olof, Kevin,
>>
>> On Mon, Aug 12, 2013 at 04:34:22PM +0100, Lorenzo Pieralisi wrote:
>>> Hi Olof, Kevin,
>>>
>>> please pull this patch series that provides a CPU idle driver for the vexpress
>>> TC2 testchip, and it is a stepping stone towards an ARM unified CPU idle driver
>>> based on the MCPM framework.
>>>
>>> Series is based against this pull request from Pawel which is a strict
>>> dependency and they must be merged in order:
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/190067.html
>>
>> May I ask you please the status of this pull request ? It is to know if
>> it is ok as it is or I have to do something on my side, thanks.
> 
> This needed a rebase on top of the latest version of the mcpm backend branch,
> since it's based on an older version.
> 
> I also don't see an ack from any of the cpuidle maintainers, if you want to
> take it through arm-soc you need to get them to ack it for that purpose. I see
> that you got an informal "It sounds good to me" in
> http://www.spinics.net/lists/arm-kernel/msg266442.html, but please be diligent
> in collecting these in the future.

Hi Olof,

there is my signed-off for the cpuidle patch because I wrote part of it
and Lorenzo finished it. This is why I thought it was not necessary to
add my acked-by.

> So, I've essentially applied the topmost 3 patches in a new branch that's based
> on our version of vexpress/mcpm, and merged that in.

Cool thanks !

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
