From: robh@kernel.org (Rob Herring)
Date: Wed, 18 May 2016 18:30:30 -0500
Subject: [PATCH 05/14] mfd: twl6040: Register child device for
 twl6040-pdmclk
In-Reply-To: <1463579196-5484-6-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
 <1463579196-5484-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160518233030.GA9813@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 04:46:27PM +0300, Peter Ujfalusi wrote:
> The McPDM in OMAP4/5 is using the pdmclk from twl6040 as functional clock.
> The twl6040-pdmclk driver provides a clock which can be used to make sure
> that the pdmclk is active when the McPDM is in use.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/twl6040.txt | 1 +
>  drivers/mfd/twl6040.c                             | 5 +++++
>  include/linux/mfd/twl6040.h                       | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
