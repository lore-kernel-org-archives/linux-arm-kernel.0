From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Dec 2017 17:03:09 +0100
Subject: [PATCH 2/2] arm64: allwinner: a64-sopine: Use dcdc1 regulator
 instead of vcc3v3
In-Reply-To: <1512119165-15290-2-git-send-email-jagan@amarulasolutions.com>
References: <1512119165-15290-1-git-send-email-jagan@amarulasolutions.com>
 <1512119165-15290-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171201160309.la6q22ps4t6uibfw@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, Dec 01, 2017 at 02:36:05PM +0530, Jagan Teki wrote:
> Since current tree support AXP803 regulators,
> replace fixed regulator vcc3v3 with AXP803 dcdc1 regulator.
> 
> Tested mmc0 on sopine baseboard.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Is it supposed to be a fix?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/a035a340/attachment.sig>
