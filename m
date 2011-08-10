From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Aug 2011 09:25:48 +0530
Subject: [PATCH 0/6] spi/spi-pl022 fixes
In-Reply-To: <CACRpkdatTqnSMxKzhYo=EYpP21buN0tosx1Y1aVc7RLe58wfgg@mail.gmail.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
	<CACRpkdatTqnSMxKzhYo=EYpP21buN0tosx1Y1aVc7RLe58wfgg@mail.gmail.com>
Message-ID: <4E420144.4010001@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2011 01:40 AM, Linus Walleij wrote:
> On Tue, Aug 9, 2011 at 1:05 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> 
>> This patchset mainly covers following fixes:
>> - formatting related issues
>> - Passing GFP_NOWAIT for sg allocation from tasklet
>> - Fixing calculate_effective_freq() routine
>> - Allocate/free DMA channels as and when required.
> 
> Excellent work Viresh, apart from the small comment on 4/6
> they all look good.
> 
> I also tested them all on the U300, works perfectly.
> 
> Please fixup 4/6 and respin with my:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for testing.

> 
> So that Grant can pick them up.
> 
>> I have rebased them on linux-next/master over following patch:
>>
>> commit 9be355da3bae9feb09cdaf80c3ab560f1f0172cb
>> Author: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date:   Tue Aug 9 13:30:19 2011 +1000
>>
>>    Add linux-next specific files for 20110809
> 
> They all work perfectly well on top of v3.1-rc1, please use
> mainline kernel tags as patch base if you can.
> 

Sure, can take care of this. But i have a doubt here,
What if a patch on the same driver is applied after kernel tag.
Shouldn't i rebase my patches on the latest commit available.

-- 
viresh
