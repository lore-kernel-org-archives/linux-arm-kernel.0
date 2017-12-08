From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Dec 2017 10:13:48 +0100
Subject: [PATCH] ARM: dts: sun8i-h3: Remove allwinner, leds-active-low for
 non internal PHY
In-Reply-To: <20171207182102.16127-1-clabbe.montjoie@gmail.com>
References: <20171207182102.16127-1-clabbe.montjoie@gmail.com>
Message-ID: <20171208091348.a4qo6pzgvoocoamz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 07:21:02PM +0100, Corentin Labbe wrote:
> allwinner,leds-active-low have effect only on boards which us the internal PHY.
> So this patch remove it from all boards which do not use the internal PHY.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171208/2c1e761f/attachment-0001.sig>
