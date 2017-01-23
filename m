From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Jan 2017 11:58:42 +0100
Subject: [PATCH v3 0/13] arm64: allwinner: a64: Enable MMC support
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170123105842.37q23ecxecrjr6so@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Mon, Jan 16, 2017 at 05:56:50PM +0100, Maxime Ripard wrote:
> Hi,
> 
> Here is a new attempt at getting the MMC controllers running, following the
> work done by Andre.
> 
> This has been tested on a board with one SDIO device (a Marvell WiFi chip)
> and a Kingston eMMC with 1.8V IOs.
> 
> For SDIO, the HS DDR mode works just fine. That serie also enables the
> SDR104 mode to work on the devices that are capable of this.
> 
> For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> moment, but since it's significantly more complex, and at the same time
> Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> any benefits. If there's any at some point, this can be added later.

Unless you have objections, I'd really like this to be in
4.11. There's a bunch of things where I'm not entirely sure
(especially the clock gating part), it would be great if you could
have a look.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170123/6bce5cda/attachment-0001.sig>
