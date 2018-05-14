From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 May 2018 15:41:28 +0100
Subject: [PATCH v9 04/12] arm64/acpi: Create arch specific cpu to acpi id
 helper
In-Reply-To: <20180511235807.30834-5-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-5-jeremy.linton@arm.com>
Message-ID: <d64175c1-3ab4-8854-e26e-486ada09e308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/05/18 00:57, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
