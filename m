From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 05 Dec 2014 13:34:24 +0100
Subject: [PATCH v4 1/3] clk: samsung: Fix clock disable failure because
 domain being gated
In-Reply-To: <5481955A.9000703@samsung.com>
References: <1417777254-26579-1-git-send-email-k.kozlowski@samsung.com>
 <1417777254-26579-2-git-send-email-k.kozlowski@samsung.com>
 <5481955A.9000703@samsung.com>
Message-ID: <5481A650.8020408@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sylwester,

On 12/05/2014 12:22 PM, Sylwester Nawrocki wrote:
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Can you confirm sound works with this patch on exynos5420 ? Or does
> your Tested-by refer only to successful booting ?
> 

I tested latest linux-next + "clk: samsung: Fix double add of syscore
ops after driver rebind" [0] + this series and I confirm that sound is
also working on my Exynos5420 Peach Pit Chromebook.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/11/26/290
