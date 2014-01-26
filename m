From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 26 Jan 2014 22:05:06 +0100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <52E57744.5030807@gmail.com>
References: <20140113160630.cf720268510f5e0931c24284@canb.auug.org.au>
 <52E57744.5030807@gmail.com>
Message-ID: <52E57882.6060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.01.2014 21:59, Tomasz Figa wrote:
> Hi Stephen,
>
> On 13.01.2014 06:06, Stephen Rothwell wrote:
>> Hi Mike,
>>
>> Today's linux-next merge of the clk tree got a conflict in
>> drivers/clk/samsung/clk-exynos4.c between commit 86576fbe201b ("clk:
>> samsung: exynos4: Fix definition of div_mmc_pre4 divider") from the
>> arm-soc tree and commit 2d7382375054 ("clk: exynos4: replace clock ID
>> private enums with IDs from DT header") from the clk tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary (no action
>> is required).
>
> It seems like somehow this fix-up has been lost in action and the
> conflict ended up being merged incorrectly in linux-next. Could you take
> a look?

Ehh, it's a false alarm fortunately. I've been looking at wrong ref, 
silly me. Sorry for the noise.

Best regards,
Tomasz
