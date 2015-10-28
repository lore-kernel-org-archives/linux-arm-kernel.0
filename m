From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 18:23:37 +0900
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <20151028082446.GF5828@x1>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
Message-ID: <56309419.4060908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2015 17:24, Lee Jones wrote:
> On Wed, 28 Oct 2015, Krzysztof Kozlowski wrote:
>> 2015-10-28 3:44 GMT+09:00 Joe Perches <joe@perches.com>:
>>> On Tue, 2015-10-27 at 18:15 +0000, Lee Jones wrote:
>>>> On Tue, 27 Oct 2015, Sebastian Reichel wrote:> >
>>>>> I think you should CC the people, which are changed from "M:"
>>>>> to "R:", though.
>>>> 
>>>> Yes, makes sense.
>>>> 
>>>> I'd like to collect some Maintainer Acks first though.
>>> 
>>> I think people from organizations like Samsung are actual 
>>> maintainers not reviewers.
> 
> So this all hinges on how we are describing Maintainers and
> Reviewers.
> 
> My personal definition (until convinced otherwise) is that Reviewers 
> care about their particular subsystem and/or files.  They conduct
> code reviews to ensure nothing gets broken and the code base stays in
> best possible state of worthiness.  On the other hand Maintainers
> usually conduct themselves as Reviewers but also have
> 'maintainership' duties as well; such as applying patches,
> *maintaining*, testing, rebasing, etc, an upstream branch and
> ultimately sending pull-requests to higher level Maintainers i.e.
> Linus.  Maintainers also have the ultimate say (unless over-ruled by
> Linus etc) over what gets applied.

Okay, sounds reasonable... so if a person performs reviews plus he does
some of the other activities (not all) then who is he?

For example reviewing + testing + fixing bugs + cleaning up (sending
patches from time to time)?

Would that be sufficient requirement to call him maintainer of a driver?
Or maybe all of these requirements must be met (including handling of
patches and sending pull reqs)?


>>> Their drivers are not thrown over a wall and forgotten.
>> 
>> At least for Samsung Multifunction PMIC drivers (and some of Maxim 
>> MUICs and PMICs) these are actively used by us in existing and new 
>> products. They are also continuously extended and actually
>> maintained. This means that it is not only about review of new
>> patches but also about caring that nothing will become broken.
> 
> Exactly.  This what I expect of any good code Reviewer.
> 
>> I would prefer to leave the "SAMSUNG MULTIFUNCTION PMIC DEVICE 
>> DRIVERS" entry as is - maintainers.
> 
> But you aren't maintaining the driver i.e. you don't collect patches 
> and *maintain* them on an upstream branch.

Indeed, we don't. However are other non-reviewing activities sufficient?

> Granted some of you guys 
> are doing a great job of maintaining branches on your downstream or 
> BSP kernels, but conduct a Reviewer type role for upstream.

You mentioned also the "ultimate say over what gets applied" - which in
this particular case is interesting to us because we have direct
interest in these drivers being in a good shape and doing things we
expect them to do. Like representing the interest of users.

Of course one could say that every upstreaming person has such
expectations... but some of the upstreamers just send a driver for one
device. Or extend driver for one device. In this case this is a family
of devices used on all of our Exynos SoC products and we care about all
of them.


> You guys are pushing back like this is some kind of demotion.
> That's not the case at all.  All it does is better describe the (very
> worthy) function you *actually* provide.

It is getting into dispute about entire change of yours... which is not
what I want. I agree with your general idea but I was referring only to
that particular case - the Samsung PMICs (and Maxim PMICs/MUICs which
would fall into same category).

Best regards,
Krzysztof
