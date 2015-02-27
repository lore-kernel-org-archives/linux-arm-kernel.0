From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 28 Feb 2015 00:38:59 +0100
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <20150227214941.GB12821@x1> (Lee Jones's message of "Fri, 27 Feb
 2015 21:49:41 +0000")
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <87385r3uk9.fsf@free.fr> <20150227214941.GB12821@x1>
Message-ID: <87sidq3ox8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:

>> I wonder why there is a need for a new clock when CLK_IGNORE_UNUSED does
>> exist. What is the usecase that is covered by this patchset which is not used by
>> CLK_IGNORE_UNUSED clock flag ?
>> 
>> And if that reason exists, I'd like to find it in the commit message.
>
> The problem is applying that flag in a generic way.
>
> However, I guess you haven't seen this [1] yet?
>
> [1] https://lkml.org/lkml/2015/2/27/548
I have.

And yet :
 1) This won't go in a _commit_ message (as opposed to cover-letter). Moreover
    it doesn't specify which usecase is not covered by CLK_IGNORE_UNUSED, it
    says, up to my understanding, that is it another way to have to
    CLK_IGNORE_UNUSED flag applied.

 2) I still fail to see why this is necessary
    IOW why declaring the mandatory always-on clocks with the proper flag should
    be augmented with a new clock list. Isn't the existing flag the generic way
    ?

I might not understand the real motivation behind that of course, that's why I'm
asking.

Cheers.

-- 
Robert
