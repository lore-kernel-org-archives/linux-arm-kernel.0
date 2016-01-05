From: wangnan0@huawei.com (Wangnan (F))
Date: Tue, 5 Jan 2016 13:09:03 +0800
Subject: [RFC PATCH] arm64: perf test: Improbe bp_signal
In-Reply-To: <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
References: <20160104165535.GI1616@arm.com>
 <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
Message-ID: <568B4FEF.5030508@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/5 12:58, Wang Nan wrote:
> Will Deacon [1] has some question on patch [2]. This patch improves
> test__bp_signal so we can test:
>
>   1. A watchpoint and a breakpoint that fire on the same instruction
>   2. Nested signals
>
> For detail of this patch see the comment in patch body.
>
> Test result:
>
>   On both x86_64:

On x86_64 and arm64.

Sorry.
