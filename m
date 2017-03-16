From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 16 Mar 2017 09:04:40 +0100
Subject: [PATCH 0/2] STM32F4 clock fixes
In-Reply-To: <20170315204307.GK10239@codeaurora.org>
References: <1489588071-18164-1-git-send-email-gabriel.fernandez@st.com>
 <20170315204307.GK10239@codeaurora.org>
Message-ID: <d400ff60-06ce-c765-981a-2dce4b1de89d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 03/15/2017 09:43 PM, Stephen Boyd wrote:
> On 03/15, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch-set contains 2 fixes.
>> One concerning exclusion of wrong values for PLLQ (0 & 1)
>> And the second is a fix about timeout management of PLL and LSE/LSI clocks.
> But neither of the patches have a "Fixes" tag. Can you please
> indicate what commits they're fixing?
>
Okay i will send a v2 with "Fixes" tags

BR

Gabriel
