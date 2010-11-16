From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 16 Nov 2010 22:48:47 +0000
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101116204554.GB5016@angua.secretlab.ca>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
	<20101116113409.GH3338@sirena.org.uk>
	<20101116204554.GB5016@angua.secretlab.ca>
Message-ID: <20101116224846.GA24623@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 01:45:54PM -0700, Grant Likely wrote:
> On Tue, Nov 16, 2010 at 11:34:09AM +0000, Mark Brown wrote:

> > You did also say you were going to write helpers to make this easier - I
> > do fear that we're going to end up with far too much boiler plate code
> > in machine drivers if we have to open code this.  I guess device tree is
> > going to need the helpers anyway :)

> Yup, and I will, but as can be seen the boilerplate required is
> actually pretty minimal, and I'd like to have a couple of platforms to
> work with before actually settling on what the helpers need to look
> like.

Yeah, but I do have a bit of nervousness about the scalability of open
coding and the possibility that we'll come up with a better approach so
I'd be a bit more comfortable if we didn't have code in random board
files as they're always the hardest thing to update.
