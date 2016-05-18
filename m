From: robh@kernel.org (Rob Herring)
Date: Wed, 18 May 2016 18:31:41 -0500
Subject: [PATCH 14/14] ASoC: omap-mcpdm: Add support for pdmclk clock
 handling
In-Reply-To: <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
 <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160518233141.GA10395@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 04:46:36PM +0300, Peter Ujfalusi wrote:
> McPDM module receives it's functional clock from external source. This
> clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
> available all register accesses to McPDM fails and the module is not
> operational.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/sound/omap-mcpdm.txt | 10 ++++++++++
>  sound/soc/omap/omap-mcpdm.c                            | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
