From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 18 Apr 2011 09:23:51 -0700
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTindYL9RHsc0MtY76RSr05qD0AU5Vg@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTindYL9RHsc0MtY76RSr05qD0AU5Vg@mail.gmail.com>
Message-ID: <BANLkTi=B9izP5N5iPnZDLdaQzBQ+egyo=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 8:17 AM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
>
> Could you please just apologize for the pointless diffstat complain,
> so we could go on?

Ehh. They aren't pointless, and I'm _this_ close to just stopping
pulling from some people unless things improve.

> Dear Russel.
>
> Please don't take the offense. Linus might be a dickhead at times, and
> sometimes he's wrong, but I'm sure he did not mean to hurt you.

Umm. The "some people" who need to get their shit together was never
Russell (and we've been emailing in private about it). We may not
agree about every detail, but on the whole we're not at all butting
heads.

Why do you think he posted that email with those arm statistics?

It's the _machine/platform_ guys who are trouble.

Hint for anybody on the arm list: look at the dirstat that rmk posted,
and if your "arch/arm/{mach,plat}-xyzzy" shows up a lot, it's quite
possible that I won't be pulling your tree unless the reason it shows
up a lot is because it has a lot of code removed.

People need to realize that the endless amounts of new pointless
platform code is a problem, and since my only recourse is to say "if
you don't seem to try to make an effort to fix it, I won't pull from
you", that is what I'll eventually be doing.

Exactly when I reach that point, I don't know.

                      Linus
