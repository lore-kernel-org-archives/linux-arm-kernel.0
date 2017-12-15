From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Dec 2017 16:23:17 -0600
Subject: [PATCH 1/3] dt-bindings: bcm2836-l1-intc: add interrupt polarity
 support
In-Reply-To: <1513024752-11246-2-git-send-email-stefan.wahren@i2se.com>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
 <1513024752-11246-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20171215222317.rljnn24gwfofocub@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 09:39:10PM +0100, Stefan Wahren wrote:
> This increases the interrupt cells for the 1st level interrupt controller
> binding in order to describe the polarity like on the other ARM platforms.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
