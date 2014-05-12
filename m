From: dianders@google.com (Doug Anderson)
Date: Mon, 12 May 2014 09:36:15 -0700
Subject: [PATCH] ARM: mm: Add workaround for erratum 763126
In-Reply-To: <CAFY15YHPSLMh6iA1PQHjsneL_Kxarc0xL5uJ7_px71cbmJbrgQ@mail.gmail.com>
References: <1399528508-2806-1-git-send-email-arjun.kv@samsung.com>
 <CAD=FV=XeYdgqk3-CpS2NNXFAnn+uGDC6844d-L6vfS=SYEuw-Q@mail.gmail.com>
 <20140508173853.GG8981@arm.com>
 <CAD=FV=X0jQvmA07XZEKT-3FAOaE3p0qCLPUCJKR8Ux1=o46cVQ@mail.gmail.com>
 <20140508180534.GI8981@arm.com>
 <CAFY15YHPSLMh6iA1PQHjsneL_Kxarc0xL5uJ7_px71cbmJbrgQ@mail.gmail.com>
Message-ID: <CAD=FV=Vned903yhjQoxyKrR9GzwqfqxoCGJyc_2J=kWvTSrBVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arjun,

On Fri, May 9, 2014 at 6:56 AM, arjun kv <kvarjun@gmail.com> wrote:
> Hi All,
>
>
> As Doug already mentioned, we have not observed an issue which could have
> been triggered by this erratum.
> Nor do we have a method to actually trigger the livelock.
> But if it improves the performance and has no real side effects, we could at
> least land this in our local tree?

Right, this is not a discussion for upstream anymore.  If Will and
Catalin believe that this errata will not actually hit and that the
worst case is a performance problem then not applying it makes sense.

We can continue the discussion in
<https://chromium-review.googlesource.com/#/c/169732/>, but given what
I see here I'd even vote that we don't need to apply this locally.


Thanks to all for the review!

-Doug
