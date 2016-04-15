From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 15 Apr 2016 17:04:55 +0800
Subject: [PATCH 3/3] arm64: defconfig: Enable ACPI
In-Reply-To: <1460706823-16566-3-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
 <1460706823-16566-3-git-send-email-broonie@kernel.org>
Message-ID: <5710AEB7.4050108@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/4/15 15:53, Mark Brown wrote:
> Enable ACPI by default to support testing of ACPI only systems and
> ensure that defconfig will boot on anything, for arm64 this is not done
> in Kconfig since a very large proportion of arm64 systems have no ACPI
> at all.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>


Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
