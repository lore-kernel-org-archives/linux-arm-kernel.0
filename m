From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 17:11:09 -0700
Subject: [PATCH 1/2] clk: samsung: exynos5260: Move struct
 samsung_cmu_info to init section
In-Reply-To: <57BD5CFB.5050500@samsung.com>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
 <1471834185-20249-2-git-send-email-cw00.choi@samsung.com>
 <CGME20160823005523epcas1p3993794ba487bb055cbf8a0b247fcb280@epcas1p3.samsung.com>
 <20160823005512.GP6502@codeaurora.org>
 <57BBB66E.2060807@samsung.com>
 <84e40b9b-1e08-24e0-f1ef-60b38b760ae6@samsung.com>
 <20160824044346.GR6502@codeaurora.org>
 <57BD5CFB.5050500@samsung.com>
Message-ID: <20160825001109.GO19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Chanwoo Choi wrote:
> On 2016? 08? 24? 13:43, Stephen Boyd wrote:
> > On 08/23, Sylwester Nawrocki wrote:
> >> So the saving is rather insignificant but the patch doesn't make
> >> things worse and I'd say it might be worth applying.
> >>
> > 
> > Sounds good. This sort of information should be in the commit
> > text though. Talking about const doesn't make any sense to me.
> 
> Do you mean that 'const' is initconst secion?

No. Marking it as initconst in the patch is correct.

> If possible, could you explain the anything
> why you don't make sense about 'const'?
> 

I'm just saying that the reasoning to move it from the text
section to the data section shouldn't be because of const. There
should be better reasons to do this, like size benefits.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
