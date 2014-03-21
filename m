From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 17:51:56 +0100
Subject: [PATCH v5 6/7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <1394723659-4995-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1394723659-4995-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394723659-4995-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201403211751.57114.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 March 2014, Maxime Ripard wrote:
> The Allwinner A31 has a 16 channels DMA controller that it shares with the
> newer A23. Although sharing some similarities with the DMA controller of the
> older Allwinner SoCs, it's significantly different, I don't expect it to be
> possible to share the driver for these two.
> 
> The A31 Controller is able to memory-to-memory or memory-to-device transfers on
> the 16 channels in parallel.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Looks good to me now,

Acked-by: Arnd Bergmann <arnd@arndb.de>
