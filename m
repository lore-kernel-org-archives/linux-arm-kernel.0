From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Jun 2015 05:46:44 +0000 (UTC)
Subject: [PATCHv3 00/10] ARM: DRA7: add display support
In-Reply-To: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1506010538330.14902@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi

On Wed, 6 May 2015, Tomi Valkeinen wrote:

> This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
> DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
> is added.
> 
> This series is v3, and is based on v4.1-rc2. There are no differences to v2,
> except rebased and tested.

Are you still planning to move the DESHDCP clock enable to the beginning 
of the series to avoid the warnings, per:

http://www.spinics.net/lists/arm-kernel/msg410968.html

?

Also, not sure if you can arrange for someone at TI to send over a DRA7xx 
board for the testbed, but it would be nice to have a board to test these 
patches with, to avoid issues like the one mentioned in your E-mails...


- Paul
