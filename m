From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Jun 2012 21:56:37 +0800
Subject: [RFC] Support for 'Coda' video codec IP.
In-Reply-To: <20120620133148.GP3978@opensource.wolfsonmicro.com>
References: <1340115094-859-1-git-send-email-javier.martin@vista-silicon.com>
 <20120619181717.GE28394@pengutronix.de>
 <CACKLOr1zCp2NfLjBrHjtXpmsFMHqhoHFPpghN=Tyf3YAcyRrYg@mail.gmail.com>
 <20120620090126.GO28394@pengutronix.de>
 <20120620100015.GA30243@sirena.org.uk>
 <20120620130941.GB2253@S2101-09.ap.freescale.net>
 <20120620133148.GP3978@opensource.wolfsonmicro.com>
Message-ID: <20120620135633.GA2513@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 02:31:48PM +0100, Mark Brown wrote:
> > I think that's the approach being taken during the transition to device
> > tree.  But it's definitely a desirable thing to remove those board
> > files with device tree support at some point, because not having non-DT
> > users will ease platform maintenance and new feature adoption a lot
> > easier, for example linear irqdomain.
> 
> Moving to irqdomain without DT is really very easy, you just need to
> select a legacy mapping if a base is provided and otherwise all the code
> is identical - it just comes down to a field in platform data and an if
> statement.

Yeah, but I guess what I'm saying is *linear* irqdomain.

-- 
Regards,
Shawn
