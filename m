From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 10:16:12 -0500
Subject: [PATCH v2 3/6] docs: Document BCM23550 bindings
In-Reply-To: <1463002582-6875-4-git-send-email-chris.brand@broadcom.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-4-git-send-email-chris.brand@broadcom.com>
Message-ID: <20160516151612.GA7348@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 02:36:19PM -0700, Chris Brand wrote:
> Add binding document for Broadcom BCM23550 SoC.
> 
> BCM23550 has a Cluster Dormant Control IP block that holds cores
> in an idle state. Introduce a new CPU enable method in which the CDC is
> accessed to bring the core online.
> 
> Signed-off-by: Chris Brand <chris.brand@broadcom.com>
> ---
>  .../bindings/arm/bcm/brcm,bcm23550-cpu-method.txt  | 36 ++++++++++++++++++++++
>  .../devicetree/bindings/arm/bcm/brcm,bcm23550.txt  | 15 +++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  3 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt

Acked-by: Rob Herring <robh@kernel.org>
