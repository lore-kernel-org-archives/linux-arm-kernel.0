From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 28 Oct 2015 15:54:30 +0100
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <20151028143838.GG4058@x1>
References: <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
 <20151028102832.GR5828@x1>
 <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
 <1446030399.2757.83.camel@perches.com>
 <CABxcv=m+aMgtKPA-WBX9rTW8c3pnMmZgNG=NvnbaeOchdZ87hg@mail.gmail.com>
 <20151028113932.GS5828@x1> <20151028121454.GA4058@x1>
 <CABxcv=kCuYaYWgnvEUuTGv1RXdS6_3DR=6fnzHhAh7V-KFfCrQ@mail.gmail.com>
 <20151028133438.GC4058@x1>
 <CABxcv==Ag3ARUtQYZdfqBELAJ_CwU3to9YxmgG1yBbUJ-h9xrw@mail.gmail.com>
 <20151028143838.GG4058@x1>
Message-ID: <CABxcv=mL5jxS45EH7g=uYR2-xk3azW_QXPqK27FkkxAHy=nyGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

[removed since we have been discussing the same back and forth]

On Wed, Oct 28, 2015 at 3:38 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> No need for that, I already explained my point of view several times
>> and you just think I'm wrong because I don't agree with you. So let's
>> just agree on disagree ;-)
>
> I do think you're wrong.  And you think I am wrong.  My reasoning is
> based on logic, common sense and words, and yours is based on, well, I
> really don't know. ;)
>

My reasoning is based on two things basically:

1) Simplicity: it is easier to think in terms of developers (that post
patches) and maintainers (that reviews / acks patches) instead of
developers (that post patches), reviewers (that review patches) and
maintainers (that collect patches and push them upstream).

Individual developers posting patches should not even care what is the
flow of a patch into mainline IMHO, just who should be in copy (which
should be both the "own" of the file whatever is called and the
subsystem maintainer).

2) Consistency: I think that the developer / maintainer split is what
more people are familiar with than the developer / reviewer /
maintainer split.

I don't really have a strong opinion and I'm completely OK if all the
people that don't keep a tree are renamed to Reviewer, Author,
Whatever instead of Maintainer. The only thing that I ask is if this
could be made consistently across all subsystems and have an agreement
in consensus so developers knows what the semantics are regardless of
what subsystems they need to contribute.

> So yes, we'll have to agree to disagree or neither of us will get any
> real work done today.
>

Agreed, I spent most of my morning on this thread ;)

Best regards,
Javier
