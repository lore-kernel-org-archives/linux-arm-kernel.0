From: davej@redhat.com (Dave Jones)
Date: Tue, 30 Jul 2013 18:14:35 -0400
Subject: [Ksummit-2013-discuss] [ARM ATTEND] catching up on exploit
 mitigations
In-Reply-To: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
Message-ID: <20130730221435.GA22240@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:05:40PM -0700, Kees Cook wrote:
 
 > - fuzzing (is anyone running trinity or similar on the ARM tree?)
 
Someone was kind enough to send me an arm chromebook, so I tried this just
last week (albeit, on the 3.4 kernel it shipped with). The results make
me think the answer is a resounding 'no'.

I don't have time to build more recent kernels on it, but I wouldn't
be surprised to find that things aren't much better (If they are, someone
is seriously sucking at backporting stuff to stable).

There's no ARM64 support yet in trinity, though it'd be easy to add for
someone with hardware. Again, wouldn't be surprised at all to learn there
are bugs there (It's been true of every new arch ported to so far).

On the subject of trinity, I've been hesitant about proposing a slot
at k-s this year, though if there's interest I'm always happy to talk
about it, and get feedback for new places it could go..

	Dave
