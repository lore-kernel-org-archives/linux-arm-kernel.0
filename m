From: davej@redhat.com (Dave Jones)
Date: Tue, 30 Jul 2013 20:04:44 -0400
Subject: [Ksummit-2013-discuss] [ARM ATTEND] catching up on exploit
 mitigations
In-Reply-To: <20130730235834.GD30725@blackmetal.musicnaut.iki.fi>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <20130730221435.GA22240@redhat.com>
 <20130730231120.GC30725@blackmetal.musicnaut.iki.fi>
 <20130730231533.GA26824@redhat.com>
 <20130730235834.GD30725@blackmetal.musicnaut.iki.fi>
Message-ID: <20130731000444.GC1281@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 02:58:34AM +0300, Aaro Koskinen wrote:

 > Anyway, I think it would be interesting to learn about arch-specific
 > bugs discovered with trinity. Quickly thinking, the results should be
 > mostly same regardless of the architecture since the code being tested
 > is generic especially when running as a regular user. But of course
 > there are 32/64-bit and big-endian/little-endian and such differences,
 > and maybe some permission bugs (likely in vendor kernels).

To use ARM as an example, the bugs I've seen have mostly been in arch specific
code that does things like page-table manipulation.  The chromebook bugs I
was hitting for eg were various kinds of PTE corruption warnings. 

ISTR the ia64 & sparc64 bugs it discovered long ago were also due to
things like missing cache flushes, as well as trivial fence-post errors.

	Dave
