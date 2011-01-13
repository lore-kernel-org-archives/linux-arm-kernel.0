From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 23:39:58 +0000
Subject: [PATCH v2] Add i.MX23/28 auart support
In-Reply-To: <1294924476-10653-1-git-send-email-s.hauer@pengutronix.de>
References: <1294924476-10653-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110113233958.GI24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 02:14:34PM +0100, Sascha Hauer wrote:
> This is the second version of these patches. I have reworked the driver to
> support the NPCK, BRKINT, PARMRK, IGNPAR, IGNBRK and cflag CREAD flags. I have
> tested these flags to the best of my knowledge, but it's sometimes hard to
> judge if the behaviour is expected.

Well, it passes code inspection, so I'm now happy with it.
