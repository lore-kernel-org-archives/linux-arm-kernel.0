From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 24 Oct 2018 19:13:34 +0100
Subject: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for
 PLL_MIPI
In-Reply-To: <20181023155035.9101-13-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-13-jagan@amarulasolutions.com>
Message-ID: <20181024181334.lul7ta7ijluwfb7v@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 09:20:32PM +0530, Jagan Teki wrote:
> A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
> using minimum 500MHz can't release the clock and which
> is not working.
>
> So use working minimum rate as 300MHz which is tested on
> Bananapi DSI panel.

I'm not quite sure what you mean by that. What do you mean by "500MHz
can't release the clock"? Why would 300MHz work better then? Should be
avoid reaching 500MHz if it's a frequency in the valid range?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181024/91584208/attachment.sig>
