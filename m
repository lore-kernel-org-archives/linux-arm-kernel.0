From: keescook@chromium.org (Kees Cook)
Date: Tue, 24 Jun 2014 09:43:58 -0700
Subject: [PATCH v7 1/1] man-pages: seccomp.2: document syscall
In-Reply-To: <53A95187.4010805@gmail.com>
References: <20140623220150.GM5412@outflux.net>
	<53A95187.4010805@gmail.com>
Message-ID: <CAGXu5j+A1WCA13rRnREh_m0kwsYfBrZSwB25NXEdpQNpgjJfyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 3:23 AM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 06/24/2014 12:01 AM, Kees Cook wrote:
>> Combines documentation from prctl, and in-kernel seccomp_filter.txt,
>> along with new details specific to the new syscall.
>
> Great work on the man page, Kees! (BTW, just looking at the complexity detailed
> there further supports the decision to grant this functionality as a separate
> syscall, rather than multiplexed into prctl(2).

Great, thanks!

> Would there be some suitable, not too long program that we
> could put in the man page as an example for using filters?

Sure thing. I can modify the "dropper" sample in samples/seccomp. I
will resend the man-page with that added.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
