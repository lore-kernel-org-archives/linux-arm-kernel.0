From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 31 Jul 2013 02:11:20 +0300
Subject: [Ksummit-2013-discuss] [ARM ATTEND] catching up on exploit
 mitigations
In-Reply-To: <20130730221435.GA22240@redhat.com>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <20130730221435.GA22240@redhat.com>
Message-ID: <20130730231120.GC30725@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 30, 2013 at 06:14:35PM -0400, Dave Jones wrote:
> On Tue, Jul 30, 2013 at 12:05:40PM -0700, Kees Cook wrote:
>  > - fuzzing (is anyone running trinity or similar on the ARM tree?)
>  
> Someone was kind enough to send me an arm chromebook, so I tried this just
> last week (albeit, on the 3.4 kernel it shipped with). The results make
> me think the answer is a resounding 'no'.

Shouldn't you run trinity only under QEMU or similar virtual
environment? Don't know about chromebook, but on some of my ARM boards
a misbehaving kernel could at least in theory brick the board...

A.
