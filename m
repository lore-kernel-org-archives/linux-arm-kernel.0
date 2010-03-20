From: martinwguy@gmail.com (Martin Guy)
Date: Sat, 20 Mar 2010 18:40:48 +0000
Subject: [PATCH v2 2/3] ep93xx: added chip revision reading function
In-Reply-To: <20100320182500.GF30801@buzzloop.caiaq.de>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003201107s758b420bmafa154714a8a8fee@mail.gmail.com>
	<20100320182500.GF30801@buzzloop.caiaq.de>
Message-ID: <56d259a01003201140o8852165w7d1b3384927e70f7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/20/10, Daniel Mack <daniel@caiaq.de> wrote:
> On Sat, Mar 20, 2010 at 06:07:50PM +0000, Martin Guy wrote:
>  >   The chip revision is normally placed in the global unsigned int
>  > "system_rev", which is also reported by /proc/cpuinfo.
>
> No, that's the hardware revision number, which is different from the
>  chip revision number.

The board revision? Right, thanks. I don't see a place to report this
in cpuinfo, since it is the SoC revision, which is neither the ARM CPU
it contains nor the board that conatins the SoC.

> If the ep93xx provides a unique serial number, then this could be an
>  idea. I would still only set it in case it has not been given by the
>  bootloader though.

It does, world-unique, burned into the chip. Thanks again.

    M
