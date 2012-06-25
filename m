From: marex@denx.de (Marek Vasut)
Date: Mon, 25 Jun 2012 18:02:53 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120625154354.GC2342@S2101-09.ap.freescale.net>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
 <201206232047.33228.marex@denx.de>
 <20120625154354.GC2342@S2101-09.ap.freescale.net>
Message-ID: <201206251802.53389.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sat, Jun 23, 2012 at 08:47:32PM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > This patch configures the I2C bus timing registers according
> > > to information passed via DT. Currently, 100kHz and 400kHz
> > > modes are supported.
> > 
> > [...]
> > 
> > Is there any reason why this can not be merged other than the timing
> > registers goo (which I believe shall stay as in the datasheet until we
> > figure out if it's even reasonable to add some computation there).
> 
> I assume this is a question for Wolfram.  But I guess part of the reason
> is there is still one comment from me staying unresolved.

Ah, you mean about the audio? I'll poke into it tonight.

Best regards,
Marek Vasut
