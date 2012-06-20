From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Jun 2012 22:03:56 +0800
Subject: [RFC] Support for 'Coda' video codec IP.
In-Reply-To: <20120620100015.GA30243@sirena.org.uk>
References: <1340115094-859-1-git-send-email-javier.martin@vista-silicon.com>
 <20120619181717.GE28394@pengutronix.de>
 <CACKLOr1zCp2NfLjBrHjtXpmsFMHqhoHFPpghN=Tyf3YAcyRrYg@mail.gmail.com>
 <20120620090126.GO28394@pengutronix.de>
 <20120620100015.GA30243@sirena.org.uk>
Message-ID: <20120620140354.GB2513@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 11:00:15AM +0100, Mark Brown wrote:
> The approach a lot of platforms have been taking is that it's OK to keep
> on maintaining existing boards using board files (especially for trivial
> things like adding new devices).

If the device is added without introducing any platform_data, we may
take it as trivial things, but otherwise we are just creating something
making the later device tree conversion difficult.

-- 
Regards,
Shawn
