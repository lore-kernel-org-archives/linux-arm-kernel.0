From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 14:47:49 +0100
Subject: i.MX consolidation patches
In-Reply-To: <20110601123522.GE23771@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
Message-ID: <20110601134749.GI3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 02:35:22PM +0200, Sascha Hauer wrote:
> This series should be orthogonal to yours. I will prepare an update to
> this series. In particular I'm not comfortable with breaking uImage
> support.

We probably should disable the uImage target when p2v patching is
enabled to prevent people getting nasty surprises.
