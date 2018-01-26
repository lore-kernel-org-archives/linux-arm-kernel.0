From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Fri, 26 Jan 2018 10:09:23 +0800
Subject: [PATCH v4 0/4] arm64/ras: support sea error recovery
In-Reply-To: <d6fb667b-402c-00df-fc56-1252261fbbe1@codeaurora.org>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
 <d6fb667b-402c-00df-fc56-1252261fbbe1@codeaurora.org>
Message-ID: <7a14f1fb-6176-1033-8121-87c872c99c8c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 2018/1/26 1:11, Tyler Baicar wrote:
> For this series - Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> 
> Note that this will probably need to be rebased on top of these patches:

Thank you for your testing, I'll rebase then.

> 
> https://patchwork.codeaurora.org/patch/415877/
> https://patchwork.codeaurora.org/patch/415879/
> 
> With that, the first patch should be able to be removed because the above patches already define the ARM error types:
> 
> +#define CPER_ARM_CACHE_ERROR            0
> +#define CPER_ARM_TLB_ERROR            1
> +#define CPER_ARM_BUS_ERROR            2
> +#define CPER_ARM_VENDOR_ERROR            3

-- 
Thanks,
Xie XiuQi
