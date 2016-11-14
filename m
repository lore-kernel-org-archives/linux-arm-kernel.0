From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2016 21:53:56 +0100
Subject: [PATCH] ARM: sun8i: sina33: Enable USB gadget
In-Reply-To: <20161104144439.4469-1-maxime.ripard@free-electrons.com>
References: <20161104144439.4469-1-maxime.ripard@free-electrons.com>
Message-ID: <20161114205356.h5aaeg7gwqlrx5du@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 03:44:39PM +0100, Maxime Ripard wrote:
> The micro-USB on the SinA33 has a somewhat interesting design in the sense
> that it has a micro USB connector, but the VBUS is (supposed to be)
> controlled through an (unpopulated) jumper.
> 
> Obviously, that doesn't work really well, and only the peripheral mode
> really works. Still enable it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/9b9d417b/attachment-0001.sig>
