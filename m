From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 13:29:34 +0100
Subject: [PATCH v10 09/17] xen/hvm/params: Add a new delivery type for
 event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <1459525755-36968-10-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-10-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5705012E.30901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 01/04/2016 16:49, Shannon Zhao wrote:
> This new delivery type which is for ARM shares the same value with
> HVM_PARAM_CALLBACK_TYPE_VECTOR which is for x86.
>
> val[15:8] is flag: val[7:0] is a PPI.
> To the flag, bit 8 stands the interrupt mode is edge(1) or level(0) and
> bit 9 stands the interrupt polarity is active low(1) or high(0).
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall
