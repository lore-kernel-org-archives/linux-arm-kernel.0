From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 19 Jan 2011 11:05:48 -0500 (EST)
Subject: RFC: Host-endian device tree format
In-Reply-To: <AANLkTi==KLWXAv79u32ioQ9eSr7JEii7fW93WPPNdAez@mail.gmail.com>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
	<AANLkTikoZj1WSpE8QNSRiF3oFL4qAb68kNnCKdExvBz7@mail.gmail.com>
	<AANLkTi=xdJ_c3LvCFkeqBRNDf6TSC40Fjxihm9eSeMmf@mail.gmail.com>
	<alpine.LFD.2.00.1101191031481.8580@xanadu.home>
	<AANLkTi==KLWXAv79u32ioQ9eSr7JEii7fW93WPPNdAez@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101191101230.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jan 2011, Grant Likely wrote:

> On Wed, Jan 19, 2011 at 8:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Wed, 19 Jan 2011, Dave Martin wrote:
> >> On Wed, Jan 19, 2011 at 1:41 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >> > The dtb isn't so much bigendian as it is network byte order.
> >>
> >> (For me, "network byte order" is a euphemism ... <insert
> >> unconstructive rant here>)
> >
> > I concur.
> 
> meh. it's all about conventions.  When talking about external data, it
> is far more important for everyone to agree on the same representation
> than it is to tailor to each platforms preferences.

Exactly what I said, using different words.

> That said, rant
> away!  I love a good tangent.

The actual problem is not that DT chose to use big endian ordering, but 
rather that BE ordering was invented in the first place.  ;-)


Nicolas
