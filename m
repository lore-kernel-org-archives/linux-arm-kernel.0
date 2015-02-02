From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 02 Feb 2015 10:53:16 -0800
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Message-ID: <54CFC79C.2040005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2015 7:55 PM, Wang, Yalin wrote:
> This patch change non-atomic bitops,
> add a if() condition to test it, before set/clear the bit.
> so that we don't need dirty the cache line, if this bit
> have been set or clear. On SMP system, dirty cache line will
> need invalidate other processors cache line, this will have
> some impact on SMP systems.
>

Any actual numbers to give an idea of the impact?

Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
