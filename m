From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 12 Oct 2012 22:44:52 +0530
Subject: [PATCH V2 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <20121012162057.GG12801@game.jcrosoft.org>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
 <20121012145027.GF12801@game.jcrosoft.org>
 <CAKohpomvCkzSuP1GLBXmDTRCHeKXDgGwwXQ+TzU=Jekmozzo=A@mail.gmail.com>
 <20121012162057.GG12801@game.jcrosoft.org>
Message-ID: <CAKohpokY9PVTVh6nvPdj9+v0iLeuCOWMmpgaEDqSqNBxqf13WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2012 21:50, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
>> >> - pass platform data via DT, non-DT way still takes precedence if both are used.
>> > why keep it  all platform are DT
>>
>> I would love to remove that, but not sure if somebody want's the non-DT
>> way too.
>>
>> I didn't wanted to get into fixing user SoCs of this driver.
> no drop it at the mailine if do not need it

But what's the harm in keeping it until we are sure, all users of it have
moved into DT? It is not adding any overhead for DT case. And this
is what most of the drivers today are doing, because not every platform
is DT compatible.

This driver is used in multiple architectures, not only ARM.

--
viresh
