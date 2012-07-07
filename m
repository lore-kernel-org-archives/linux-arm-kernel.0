From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 7 Jul 2012 13:59:27 +0300
Subject: [PATCH 0/3] hwspinlock: a bug fix, trivial changes
In-Reply-To: <4FF66FBD.5090601@renesas.com>
References: <4FF66FBD.5090601@renesas.com>
Message-ID: <CAK=WgbYgVoB+B3P6NLpd2t=F9PVA_m7Nbou4k1aq8BGvjJhvNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shinya,

On Fri, Jul 6, 2012 at 7:55 AM, Shinya Kuribayashi
<shinya.kuribayashi.px@renesas.com> wrote:
> Recently I wrote a hwspinlock driver for our devices

Great! looking forward to see it :)

> and during
> the review and debug process, we found a bug in the core code.
> Could you take a look please?

I looked and it's great. Will send to Linus soon.

> The first patch is a bug fix.  The latter two patches are what I
> think nice-to-have.  If you find useful, just take it, thanks!

I commented on the latter two (generally both look ok sans a small
outstanding comment).

Thanks,
Ohad.
