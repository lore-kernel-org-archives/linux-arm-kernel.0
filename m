From: keescook@chromium.org (Kees Cook)
Date: Tue, 6 Aug 2013 14:44:12 -0700
Subject: [ARM ATTEND] catching up on exploit mitigations
In-Reply-To: <20130803000321.GR23006@n2100.arm.linux.org.uk>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <20130803000321.GR23006@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jJv-hp3wbaqJyk2pPHASemhepy+C4X+9np+xcbrBfnZEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 5:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jul 30, 2013 at 12:05:40PM -0700, Kees Cook wrote:
>> - vector table protections (needs to be protected like the x86_64
>> vsyscall table, RO, etc)
>
> (Dropped some mailing lists to reduce the visibility of this as its
> soo close to the patches being merged...)
>
> On the subject of this, those who are following what's going on at the
> blackhat conference will be aware that there was a presentation
> yesterday on this very subject.
>
> Now that the presentation has been done, and the fixes are now merged
> into Linus' tree, I can now talk about this.

This all sounds excellent. Thanks for working on it!

Do you see other areas that might need similar attention, or could
benefit from more hardening?

Thanks,

-Kees

-- 
Kees Cook
Chrome OS Security
