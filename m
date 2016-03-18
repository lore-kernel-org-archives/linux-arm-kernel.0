From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 15:06:17 -0500
Subject: [PATCH 4/4] dma: qcom_hidma: read the channel id from HW
In-Reply-To: <1457732994-11175-5-git-send-email-okaya@codeaurora.org>
References: <1457732994-11175-1-git-send-email-okaya@codeaurora.org>
 <1457732994-11175-5-git-send-email-okaya@codeaurora.org>
Message-ID: <20160318200617.GA28108@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 04:49:54PM -0500, Sinan Kaya wrote:
> Removing the flexibility to choose the event channel as there is no real
> use case right now. We have been using the values in ACPI that match the HW
> defaults. OS is reading the event-channel from the HW register now.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  3 --

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/dma/qcom/hidma.c                           | 39 +---------------------
>  2 files changed, 1 insertion(+), 41 deletions(-)
