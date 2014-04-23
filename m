From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 14:35:03 +0200
Subject: [PATCH v5 7/7] ARM: sun6i: dt: Add A31 DMA controller to DTSI
In-Reply-To: <1394723659-4995-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1394723659-4995-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394723659-4995-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201404231435.03920.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 March 2014, Maxime Ripard wrote:
> Now that we have a DMA driver, we can add the DMA bindings in the DTSI for the
> controller and the devices supported that can use DMA.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

But why does this patch have to wait for the driver to get merged?
