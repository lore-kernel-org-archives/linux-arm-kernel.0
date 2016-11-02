From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 14:32:46 +0100
Subject: [PATCH 0/3] ARM: dts: sun9i: Enable SDIO-based WiFi
In-Reply-To: <20161028101154.7350-1-wens@csie.org>
References: <20161028101154.7350-1-wens@csie.org>
Message-ID: <20161102133246.tyvdoxxzekpqhiuu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 06:11:51PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> Now that we have support for both PMICs, we can turn on the
> regulators needed for the onboard WiFi chips.
> 
> This is a fairly simple series. The WiFi chips themselves are
> supported by the brcmfmac driver, but the user needs to get an
> nvram.txt file and put it in their firmware directory, in
> addition to the firmware file in linux-firmware. Otherwise we
> just need to enable the mmc controller and supply the vmmc and
> vqmmc regulators.

Applied all three, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/f6a550a6/attachment.sig>
