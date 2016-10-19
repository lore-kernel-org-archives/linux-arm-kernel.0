From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Oct 2016 19:04:06 +0530
Subject: [PATCH V5 00/10] dmaengine: qcom_hidma: add MSI interrupt support
In-Reply-To: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
References: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20161019133406.GO2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 01:25:05AM -0400, Sinan Kaya wrote:
> The new version of the HW supports MSI interrupts instead of wired
> interrupts. The MSI interrupts are especially useful for the guest machine
> execution. The wired interrupts usually trap to the hypervisor and then are
> relayed to the actual interrupt.
> 
> The MSI interrupts can be directly fed into the interrupt controller.
> 
> Adding a new OF compat string (qcom,hidma-1.1) and ACPI string (QCOM8062)
> to distinguish newer HW from the older ones.

I was only able to apply 6 patches in this series. Which tree were these
generated against?

Please rebase rest..

-- 
~Vinod
