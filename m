From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 09:14:56 -0600
Subject: [PATCH V13 08/10] dma: qcom_hidma: read the channel id from HW
In-Reply-To: <1454106914-15857-9-git-send-email-okaya@codeaurora.org>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-9-git-send-email-okaya@codeaurora.org>
Message-ID: <20160201151455.GA10961@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 05:35:11PM -0500, Sinan Kaya wrote:
> Removing the flexibility to choose the event channel as there is no real
> use case right now. We have been using the values in ACPI that match the HW
> defaults. OS is reading the event-channel from the HW register now.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  3 --
>  drivers/dma/qcom/hidma.c                           | 39 +---------------------
>  2 files changed, 1 insertion(+), 41 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
