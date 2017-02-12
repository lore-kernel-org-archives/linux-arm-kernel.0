From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 12 Feb 2017 18:27:24 +0100
Subject: [PATCH] ARM: dts: armada-385-synology-ds116: add support for
 Synology DS116 NAS
In-Reply-To: <20170212153855.GA17141@lunn.ch>
References: <1486805073-15534-1-git-send-email-w@1wt.eu>
 <20170212004031.GA7328@lunn.ch> <20170212005350.GA18612@1wt.eu>
 <20170212011744.GB7328@lunn.ch> <20170212012418.GA17841@1wt.eu>
 <20170212153855.GA17141@lunn.ch>
Message-ID: <20170212182724.4ed100e0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, 12 Feb 2017 16:38:55 +0100, Andrew Lunn wrote:

> What you have in v2 and v3 looks good. It could be considered a bit of
> a hack, two nodes for the same hardware block. But they are used at
> different times, normal runtime, and late in the shutdown. So it works
> out O.K.

I don't really mind personally, but IMO this is clearly a hack. It
completely violates the rule that the DT should represent the HW, and
the fact that the DT should be operating system agnostic.

But anyway, there are so many things in the DT that violates those
rules that probably this hack is fine.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
