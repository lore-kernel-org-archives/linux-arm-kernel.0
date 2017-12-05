From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 09:33:16 +0100
Subject: [PATCH v2 2/2] arm64: allwinner: a64-sopine: Fix to use dcdc1
 regulator instead of vcc3v3
In-Reply-To: <1512363187-8353-2-git-send-email-jagan@amarulasolutions.com>
References: <1512363187-8353-1-git-send-email-jagan@amarulasolutions.com>
 <1512363187-8353-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171205083316.p4hpqkpzulov6aok@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 10:23:07AM +0530, Jagan Teki wrote:
> Since current tree support AXP803 regulators,
> replace fixed regulator vcc3v3 with AXP803 dcdc1 regulator where ever
> it need to replace.
> 
> Tested mmc0 on sopine baseboard.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Queued as a fix, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/7751c46d/attachment.sig>
