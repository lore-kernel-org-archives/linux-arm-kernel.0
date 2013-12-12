From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Dec 2013 10:04:15 +0100
Subject: [PATCH 04/10] net: stmmac: sunxi platfrom extensions for GMAC in
 Allwinner A20 SoC's
In-Reply-To: <52A87A74.8040807@st.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org>
 <52A5A52C.50605@st.com>
 <CAGb2v67WiCaMpJEzA_X6o7uOu6i3w3FCEz7=N5HY0amQb01SZA@mail.gmail.com>
 <52A72C6D.60100@st.com>
 <CAGb2v64qQvqJSicA6MTAxeh1sGjWY=Pk=vDq=9J3pTQW+wkXrA@mail.gmail.com>
 <52A87A74.8040807@st.com>
Message-ID: <20131212090415.GQ3651@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 11, 2013 at 02:45:08PM +0000, srinivas kandagatla wrote:
> >>> 1. .tx_coe
> >>>    This is not exported in the DT bindings.
> >>>    Looking at stmmac code, not setting this seems to disable all
> >>>    checksum offloading.
> >>
> >> Why cant this go via DT as well?
> > 
> > If you and Giuseppe are OK with this, why not?
> Am Ok with it.

Please note that I'm opposed to this until someone explain why putting
it in the DT is relevant (and not just convenient).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/016cd67e/attachment.sig>
