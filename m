From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 May 2017 14:51:47 +0200
Subject: [linux-sunxi][PATCH] ARM: dts: sun8i-h3: orange-pi-2: Enable
 audio codec
In-Reply-To: <20170510115138.21765-1-codekipper@gmail.com>
References: <20170510115138.21765-1-codekipper@gmail.com>
Message-ID: <20170510125147.GJ5465@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 11:51:38AM +0000, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The Orange Pi 2 routes the LINEOUT pins through a SGM8900 PA which
> needs to be enabled. The onboard microphone is routed to MIC1, with
> MBIAS providing power.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170510/1a3dfe55/attachment.sig>
