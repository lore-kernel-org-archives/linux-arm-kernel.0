From: robh@kernel.org (Rob Herring)
Date: Sat, 19 Mar 2016 19:17:08 -0500
Subject: [PATCH 1/3] dt/bindings: bcm2835: add interrupt-names property
In-Reply-To: <1458228273-15591-2-git-send-email-kernel@martin.sperl.org>
References: <1458228273-15591-1-git-send-email-kernel@martin.sperl.org>
 <1458228273-15591-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160320001708.GA25749@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 03:24:31PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Added standard interrupt-names property so that
> platform_get_irq_byname() can get used to fetch the
> interrupt corresponding to each dma_channel
> instead of the current platform_get_irq() with
> an assumed ordering of the interrupts.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
