From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Dec 2017 16:58:08 +0100
Subject: [PATCH v4 10/10] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <afc22693e34c11231fc85a0dc6af3ffb340ba9b2.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <afc22693e34c11231fc85a0dc6af3ffb340ba9b2.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20171201155808.rxgp7pz7nmr6tab7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 02:44:51PM +0100, Quentin Schulz wrote:
> On AXP813/818, GPIO0 and GPIO1 can be used as LDO as (respectively)
> ldo_io0 and ldo_io1.
> 
> Let's add the pinctrl properties to the said regulators.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/44cb2b61/attachment.sig>
