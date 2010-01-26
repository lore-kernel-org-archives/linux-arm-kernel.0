From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 12:04:02 +0000
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <1b68c6791001260357p62b5c10dpfa2a5ddcae0704dd@mail.gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<20100126102343.GA24843@trinity.fluff.org>
	<1b68c6791001260303m38e6e689p2ee8c2c4c6ac2af3@mail.gmail.com>
	<20100126110945.GJ15759@rakim.wolfsonmicro.main>
	<1b68c6791001260357p62b5c10dpfa2a5ddcae0704dd@mail.gmail.com>
Message-ID: <20100126120402.GO15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 08:57:56PM +0900, jassi brar wrote:
> On Tue, Jan 26, 2010 at 8:09 PM, Mark Brown

> > If they both work equally well please just go ahead and remove the old
> > driver. ?Keeping the old driver around if it doesn't work is likely to
> > result in any fixups going into that.

> ok, will submit a patch for that too.
> Btw, I don't have ln2440sbc and don't know how would it take the change,
> though I sincerely think it should be just fine.

CC the original author on the patch updating it, if they don't reply
then a build test is fine - I'd also expect it'll work fine (though
thinking about it you'll need to add the platform data for the GPIO
configuration to the 2443 instance of the struct device, I'm not sure if
that was there or not?).
