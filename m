From: carlo.caione@gmail.com (Carlo Caione)
Date: Wed, 3 Sep 2014 20:42:50 +0200
Subject: [PATCH 1/5] ARM: sun4i: Relicense the A10 DTSI under GPLv2/X11
In-Reply-To: <1409682069-7164-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1409682069-7164-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140903184250.GA8163@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 08:21:05PM +0200, Maxime Ripard wrote:
> The current GPL only licensing on the DTSI makes it very impractical for other
> software components licensed under another license.
> 
> In order to make it easier for them to reuse our device trees, relicense our
> DTSI first under a GPL/X11 dual-license. Hopefully, the DTS will follow soon.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Carlo Caione <carlo.caione@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> Cc: Emilio L?pez <emilio@elopez.com.ar>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Oliver Schinagl <oliver@schinagl.nl>
> Cc: Roman Byshko <rbyshko@gmail.com>
> Cc: Stefan Roese <sr@denx.de>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 46 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)

Acked-by: Carlo Caione <carlo@caione.org> 

-- 
Carlo Caione
