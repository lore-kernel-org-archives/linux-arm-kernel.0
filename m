From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 May 2014 16:36:42 +0200
Subject: [PATCH] irqchip: armada-370-xp: Move the devicetree binding
 documentation
In-Reply-To: <1399904860-937-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1399904860-937-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140512163642.0cac3359@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Mon, 12 May 2014 11:27:40 -0300, Ezequiel Garcia wrote:
> Move the devicetree binding documentation to the interrupt-controller
> directory, where it belongs.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/armada-370-xp-mpic.txt | 38 ----------------------
>  .../marvell,armada-370-xp-mpic.txt                 | 38 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
