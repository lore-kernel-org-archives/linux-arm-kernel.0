From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Mar 2017 17:39:03 +0000
Subject: [PATCH v3 1/5] ASoC: sun8i-codec: Remove analog "HP" widget
In-Reply-To: <20170318075509.3836-2-mylene.josserand@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-2-mylene.josserand@free-electrons.com>
Message-ID: <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 08:55:05AM +0100, Myl?ne Josserand wrote:
> The "HP" widget is already present and take part to
> the analog part (sun8i-codec-analog).
> 
> Remove it from the digital part as it is unnecessary.

I know I said to send against Linus' tree but it turns out this actually
conflicts with some of the existing fixes, please see my fixes/sunxi
branch and resend against that.  Sorry for the hassle here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/ed7e6790/attachment.sig>
