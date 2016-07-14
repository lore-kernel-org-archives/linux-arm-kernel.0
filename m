From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Jul 2016 00:02:21 +0200
Subject: [PATCH] ARM: tegra: fix erroneous address in dts
In-Reply-To: <1468514937-23250-1-git-send-email-ralf@ramses-pyramidenbau.de>
References: <1468514937-23250-1-git-send-email-ralf@ramses-pyramidenbau.de>
Message-ID: <20160714220218.GB4205@mithrandir.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 06:48:57PM +0200, Ralf Ramsauer wrote:
> c90bb7b enabled the high speed UARTs of the Jetson TK1. The address
> specification inside the dts is wrong. Fix it and use the correct
> address.
> 
> Fixes: c90bb7b9b9 ("ARM: tegra: Add high speed UARTs to Jetson TK1 device tree")
> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

These addresses are correct. The 0, prefix was dropped from the unit
address in commit b5896f67ab3c ("ARM: tegra: Remove commas from unit
addresses on Tegra124").

What's the problem that you're seeing? What's not working for you?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/3a6806c6/attachment.sig>
