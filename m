From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Jun 2010 16:57:47 +0200
Subject: [PATCH] pxa/z2: Add regulator support
In-Reply-To: <20100607113802.GB5993@sirena.org.uk>
References: <1275882020-30159-1-git-send-email-marek.vasut@gmail.com>
	<20100607113802.GB5993@sirena.org.uk>
Message-ID: <201006071657.47186.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 7. ?ervna 2010 13:38:03 Mark Brown napsal(a):
> On Mon, Jun 07, 2010 at 05:40:20AM +0200, Marek Vasut wrote:
> > Register TPS65023 regulator as found in Z2. The Z2 actually contains a
> > TPS65021, but this chip is apparently compatible.
> 
> If you're doing this you should register the chip that is actually
> present on the board and then modify the driver to bind to both device
> IDs.  That way the driver will be able to handle any differences that do
> exist.

Ok, I'll send a patch for this.
