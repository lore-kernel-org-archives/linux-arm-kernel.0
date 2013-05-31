From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 09:21:46 +0200
Subject: [PATCH 1/2] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
In-Reply-To: <CAOesGMgrdyFi3GMz52CVnhzmOYHbR5=29Ua0iS8cNbSjg6r-2A@mail.gmail.com>
References: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
 <1369866529-6372-2-git-send-email-horms+renesas@verge.net.au>
 <CACRpkdZxWsJuvrtH-=VVqAGUCpdgS3W52R4tw5-_QGpggB+1uw@mail.gmail.com>
 <20130531001735.GA26684@verge.net.au>
 <CAOesGMiTXW0mVmbBbha5S4O64yu_vM=eLxM4JyctsfONCAo4qg@mail.gmail.com>
 <20130531054517.GC5009@verge.net.au>
 <CAOesGMgrdyFi3GMz52CVnhzmOYHbR5=29Ua0iS8cNbSjg6r-2A@mail.gmail.com>
Message-ID: <CACRpkda9tjydo038exS2a=Gsvum41LyvXd=GwKh3b0Zi4rOA9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 8:11 AM, Olof Johansson <olof@lixom.net> wrote:
> [Simon]
>> As an aside, I do expect to send some more v3.10 fixes for shmobile.
>> There seem to be more than usual.
>
> A little unfortunate but it's hard to do much about.
>
> Please be conservative with what you pick up for 3.10 vs 3.11 -- Linus
> has said he really wants to see things slow down.

What we might need to think about is the evolutional pace of the ARM
kernel - compared to a few years back we have increased the change
rate by orders of a magnitude (at least that is my feeling...)

There may be some point where we actually need to tell people to
hold changes back because they are just pushing too large volumes
through one merge window, resulting in a corresponding amount of
fixes.

This merge window both Samsung Exynos and SH mobile seem to
have been a little bit trigger-happy :-/

Yours,
Linus Walleij
