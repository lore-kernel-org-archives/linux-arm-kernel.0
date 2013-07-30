From: keescook@chromium.org (Kees Cook)
Date: Tue, 30 Jul 2013 16:33:38 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] catching up on exploit
 mitigations
In-Reply-To: <20130730231533.GA26824@redhat.com>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <20130730221435.GA22240@redhat.com>
 <20130730231120.GC30725@blackmetal.musicnaut.iki.fi>
 <20130730231533.GA26824@redhat.com>
Message-ID: <CAGXu5jLQxE14Gy3x20XMyFyUQKwMQ+RU9S24H742cQevEF9Aew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 4:15 PM, Dave Jones <davej@redhat.com> wrote:
> On Wed, Jul 31, 2013 at 02:11:20AM +0300, Aaro Koskinen wrote:
>  > Hi,
>  >
>  > On Tue, Jul 30, 2013 at 06:14:35PM -0400, Dave Jones wrote:
>  > > On Tue, Jul 30, 2013 at 12:05:40PM -0700, Kees Cook wrote:
>  > >  > - fuzzing (is anyone running trinity or similar on the ARM tree?)
>  > >
>  > > Someone was kind enough to send me an arm chromebook, so I tried this just
>  > > last week (albeit, on the 3.4 kernel it shipped with). The results make
>  > > me think the answer is a resounding 'no'.
>  >
>  > Shouldn't you run trinity only under QEMU or similar virtual
>  > environment? Don't know about chromebook, but on some of my ARM boards
>  > a misbehaving kernel could at least in theory brick the board...
>
> I like to live dangerously.  Don't imitate everything you see on TV,
> or read about on lkml.
>
> More seriously, that's true if you're running trinity as root, which
> yes, I usually advise people only do in qemu etc.
>
> If you're running it as a regular user and you can brick the board,
> you might have bigger problems.

Exactly, and finding those problems tends to be worth the hardware hassle. :)

-Kees

-- 
Kees Cook
Chrome OS Security
