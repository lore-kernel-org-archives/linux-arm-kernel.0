From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:30:00 +0000
Subject: [PATCH v3 56/62] arm/acpi: Deny MMIO access of UART
In-Reply-To: <564B275A.6060309@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-57-git-send-email-shannon.zhao@linaro.org>
 <564B17E2.8030205@citrix.com> <564B275A.6060309@huawei.com>
Message-ID: <565C6B78.4000900@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 13:10, Shannon Zhao wrote:
> Regarding SMMU, since it doesn't support now, so I didn't add it but it
> could be added later.

Then please add a TODO, otherwise it's a call to forget it.

Regards,

-- 
Julien Grall
