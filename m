From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 12:04:50 +0000
Subject: [PATCH v3 56/62] arm/acpi: Deny MMIO access of UART
In-Reply-To: <1447753261-7552-57-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-57-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B17E2.8030205@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Firstly it permits full MMIO capabilities for Dom0. Then deny MMIO
> access of UART device.

I'm nearly sure we want to deny other MMIO such as the GIC regions and SMMU.

Regards,

-- 
Julien Grall
