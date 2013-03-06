From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 6 Mar 2013 10:43:37 +0530
Subject: [PATCH 1/2] ARM: exynos: pl330: Add #dma-cells for generic dma
 binding support
In-Reply-To: <201303052237.05910.arnd@arndb.de>
References: <1362375268-29405-1-git-send-email-padma.v@samsung.com>
 <201303052237.05910.arnd@arndb.de>
Message-ID: <CAAgF-Bf+rqiFUaBD=aRqry6-2z4o0Ao2L2YRm8bu1x98TfPPyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 4:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 04 March 2013, Padmavathi Venna wrote:
>>
>> This patch adds #dma-cells property to PL330 DMA controller
>> nodes for supporting generic dma dt bindings on samsung exynos
>> platforms. #dma-channels and #dma-requests are not required now
>> but added in advance.
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Should we apply these directly to the arm-soc fixes branch, or wait
> until they come back from the Samsung subarchitecture tree?

Hmm, If Kukjin can take in 3.9 rc2 it's better to go via Samsung tree.

Kukjin,

Can you please take this patch in 3.9 rc2 ?

Thanks
Padma
