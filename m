From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 3 Nov 2016 13:17:29 +0000
Subject: [PATCH V7 0/4] dmaengine: qcom_hidma: add MSI interrupt support
In-Reply-To: <1477067879-23750-1-git-send-email-okaya@codeaurora.org>
References: <1477067879-23750-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1478179048.6505.29.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-21 at 12:37 -0400, Sinan Kaya wrote:
> The new version of the HW supports MSI interrupts instead of wired
> interrupts. The MSI interrupts are especially useful for the guest
> machine
> execution. The wired interrupts usually trap to the hypervisor and
> then are
> relayed to the actual interrupt.
> 
> The MSI interrupts can be directly fed into the interrupt controller.
> 
> Adding a new OF compat string (qcom,hidma-1.1) and ACPI string
> (QCOM8062)
> to distinguish newer HW from the older ones.

Applied, thanks

-- 
~Vinod
