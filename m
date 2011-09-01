From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 1 Sep 2011 15:34:43 +0530
Subject: [PATCH V2 0/6] spi/spi-pl022 fixes
In-Reply-To: <cover.1312965741.git.viresh.kumar@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
Message-ID: <4E5F58BB.4020205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/10/2011 2:20 PM, Viresh KUMAR wrote:
> Hi Grant,
> 
> I have added Tested-by: Linus Walleij <linus.walleij@linaro.org> on all patches.
> 
> This patchset mainly covers following fixes:
> - formatting related issues
> - Passing GFP_ATOMIC for sg allocation from tasklet
> - Fixing calculate_effective_freq() routine
> - Allocate/free DMA channels as and when required.
> 

Grant,

Did you already pushed this patchset?
There are few concerns on PATCH 6/6 and i am not sure if there are any decisions
on it.
@Linus: What do you say?

So, probably you can push first 5 patches for now.

--
viresh
