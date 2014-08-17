From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 Aug 2014 10:03:33 +0200
Subject: [PATCH 00/12] ARM: sun8i: Enable pinctrl, i2c and mmc
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <20140817080333.GZ15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 17, 2014 at 11:52:06AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This series enables all the controllers on sun8i that we already have
> drivers for, excluding SPI as the tablet I have does not use it and
> I cannot test it. If there's a way to test it without external connections
> or devices please let me know.
> 
> This series is based on 3.17-rc1, however it should cleanly apply over
> the sun8i-rtc patch you've queued.
> 
> The commit logs pretty much explain themselves. Note that PLL6 is not
> implemented yet. I've some patches for the clocks that I will send later.

Merged patches 1-10.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140817/69c37926/attachment.sig>
