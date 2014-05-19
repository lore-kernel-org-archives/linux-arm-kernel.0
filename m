From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 May 2014 22:10:41 -0400
Subject: [PATCH] irqchip: armada-370-xp: Move the devicetree binding
 documentation
In-Reply-To: <1400457737-1617-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1400457737-1617-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140519021041.GE27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 18, 2014 at 09:02:17PM -0300, Ezequiel Garcia wrote:
> Move the devicetree binding documentation to the interrupt-controller
> directory, where it belongs.
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../marvell,armada-370-xp-mpic.txt}                                       | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/armada-370-xp-mpic.txt => interrupt-controller/marvell,armada-370-xp-mpic.txt} (100%)

Applied to irqchip/core

thx,

Jason.
