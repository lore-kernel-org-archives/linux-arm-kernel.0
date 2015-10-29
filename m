From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 29 Oct 2015 01:12:36 +0100
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <563160B2.7070305@samsung.com>
References: <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
 <20151028102832.GR5828@x1>
 <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
 <1446030399.2757.83.camel@perches.com>
 <CABxcv=m+aMgtKPA-WBX9rTW8c3pnMmZgNG=NvnbaeOchdZ87hg@mail.gmail.com>
 <20151028113932.GS5828@x1> <20151028121454.GA4058@x1>
 <CABxcv=kCuYaYWgnvEUuTGv1RXdS6_3DR=6fnzHhAh7V-KFfCrQ@mail.gmail.com>
 <20151028133438.GC4058@x1>
 <CABxcv==Ag3ARUtQYZdfqBELAJ_CwU3to9YxmgG1yBbUJ-h9xrw@mail.gmail.com>
 <20151028143838.GG4058@x1> <563160B2.7070305@samsung.com>
Message-ID: <CABxcv=mXD3AhWeqZJ4vigCtQ7utBgG2_BD0TKcjr2ctL2MjMbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On Thu, Oct 29, 2015 at 12:56 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 28.10.2015 23:38, Lee Jones wrote:
>> On Wed, 28 Oct 2015, Javier Martinez Canillas wrote:
>>> They are not maintainers according to your definition of maintainer
>>> that doesn't seem what most people agree with.
>>
>> "most people" so far are 3 people that I assume still want to be
>> Maintainers despite not actually conducting Maintainer duties, but
>> are rather Reviewers.  I also have 2 Acks for this patch, so thus far
>> that's 3 that agree and 3 that do not.  Unsurprisingly the ones that
>> agree are Maintainers and the ones who are not are (by my definition)
>> Reviewers -- go figure.
>>
>
> I am not sure on which side you put me finally. :)
> If there is a consensus among some more experienced developers that
> maintainer means branch and patches maintaining, then I won't see any
> problem with the patch nor with switching Samsung PMIC entries to review.
>
> In that case, that would be:
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Same for me, what I don't want is to have different meanings per
subsystems of what maintainers and reviewers mean since that could
confuse developers posting patches.

But if there is a kernel wide consensus and all subsystems entries are
going to be updated to use the same semantics and list as Reviewer to
people that don't keep git trees, then I'm OK with this patch and you
can add my:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

> Best regards,
> Krzysztof
>

Best regards,
Javier
