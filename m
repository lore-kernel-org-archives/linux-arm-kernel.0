From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Dec 2017 09:57:11 +0100
Subject: [PATCH v4 14/15] ARM: dts: sun8i: a711: Reinstate the PMIC
 compatible
In-Reply-To: <80711a93a5e49166a26ade747687d8ba4ef7a6f3.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
 <80711a93a5e49166a26ade747687d8ba4ef7a6f3.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20171219085711.r7rh6qgnah4gsygr@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 04:58:59PM +0100, Maxime Ripard wrote:
> When we added the regulator support in commit 90c5d7cdae64 ("ARM: dts:
> sun8i: a711: Add regulator support"), we also dropped the PMIC's
> compatible. Since it's not in the PMIC DTSI, unlike most other PMIC
> DTSI, it obviously wasn't probing anymore.
> 
> Re-add it so that everything works again.
> 
> Fixes: 90c5d7cdae64 ("ARM: dts: sun8i: a711: Add regulator support")
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied this one as a fix.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171219/4c612261/attachment-0001.sig>
