From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Sep 2011 12:56:05 +0200
Subject: [PATCH V2 0/6] spi/spi-pl022 fixes
In-Reply-To: <4E5F58BB.4020205@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<4E5F58BB.4020205@st.com>
Message-ID: <CACRpkdYeq9in+U_tyvb=yVuX2t5TnkUSsO+BozUGVJwZVh+4Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2011 at 12:04 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 8/10/2011 2:20 PM, Viresh KUMAR wrote:
>>
>> This patchset mainly covers following fixes:
>> - formatting related issues
>> - Passing GFP_ATOMIC for sg allocation from tasklet
>> - Fixing calculate_effective_freq() routine
>> - Allocate/free DMA channels as and when required.
>>
>
> Grant,
>
> Did you already pushed this patchset?
> There are few concerns on PATCH 6/6 and i am not sure if there are any decisions
> on it.
> @Linus: What do you say?

I agree. Acked-by: Linus Walleij <linus.walleij@linaro.org> for
all except 6/6, it's probably just as possible to keep the channel handle
taken in the driver if we modify the affected DMA driver instead.
This would be better for performance I think.

Thanks,
Linus Walleij
