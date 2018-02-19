From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 13:35:44 -0600
Subject: [PATCH V3 1/2 RESEND] dt-bindings: bcm283x: Fix register ranges
 of bcm2835-i2s
In-Reply-To: <1518778534-3328-2-git-send-email-stefan.wahren@i2se.com>
References: <1518778534-3328-1-git-send-email-stefan.wahren@i2se.com>
 <1518778534-3328-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20180219193544.eih76l5j7tlde6ul@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 11:55:33AM +0100, Stefan Wahren wrote:
> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
> 
> This patch only fixes the affected dt-bindings.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
>  Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org> 
