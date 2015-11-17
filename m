From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 11:52:40 +0000
Subject: [PATCH v3 00/62] Add ACPI support for arm64 on Xen
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B1508.3060703@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:39, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> This patch set adds ACPI support for arm64 on Xen. The design document
> could be found from [1].

Thank you for your work on it. I think this series would benefits to be
split in smaller series.

I would do a first series which split DT code from common code. So we
can get this code as soon as possible in Xen, avoid you to spend less
time rebasing your us to be spammed with 62 patches for each new version.

Regards,

-- 
Julien Grall
