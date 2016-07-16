From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jul 2016 18:06:44 -0500
Subject: [PATCH 02/10] Documentation: dt: socfpga: Add Arria10 DMA EDAC
 binding
In-Reply-To: <1468512408-5156-3-git-send-email-tthayer@opensource.altera.com>
References: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
 <1468512408-5156-3-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160716230644.GA3922@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 11:06:40AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree bindings needed to support the Altera DMA
> FIFO buffer EDAC on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
