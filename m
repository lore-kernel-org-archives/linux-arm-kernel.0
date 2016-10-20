From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 20 Oct 2016 15:18:38 +0530
Subject: [PATCH V6 00/10] dmaengine: qcom_hidma: add MSI interrupt support
In-Reply-To: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
References: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20161020094838.GY2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 01:51:42PM -0400, Sinan Kaya wrote:
> The new version of the HW supports MSI interrupts instead of wired
> interrupts. The MSI interrupts are especially useful for the guest machine
> execution. The wired interrupts usually trap to the hypervisor and then are
> relayed to the actual interrupt.
> 
> The MSI interrupts can be directly fed into the interrupt controller.
> 
> Adding a new OF compat string (qcom,hidma-1.1) and ACPI string (QCOM8062)
> to distinguish newer HW from the older ones.
> 
> v6:
> * rebase 4.9 kernel

Why???


I already told you that I have applied 6 in the last version, please dont
send me stuff which is already applied :(

-- 
~Vinod
