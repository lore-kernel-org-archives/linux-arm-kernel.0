From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Mar 2018 21:33:50 +0000
Subject: Regulator regression in next-20180305
In-Reply-To: <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
 <20180306191218.GF13586@sirena.org.uk>
 <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
Message-ID: <20180306213350.GH13586@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 05:06:48PM -0300, Fabio Estevam wrote:
> On Tue, Mar 6, 2018 at 4:12 PM, Mark Brown <broonie@kernel.org> wrote:

> > Yeah, that's what I expected.  What we really need to figure out I think
> > is what exactly is taking the lock that we end up colliding with, I
> > don't seem to be able to reproduce so I'm having to just go on staring
> > at the code here.

> Any debug options I should turn on in order to help us to understand
> more on the lock issue?

No, unfortunately, apart from the generic kernel ones (like lockdep).
I'll try to have a poke at adding some tomorrow, though I'm also
considering just dropping the series for now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180306/591e2d86/attachment.sig>
