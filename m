From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 17 Sep 2015 11:47:00 +0200
Subject: [RESEND PATCH 0/2] ST PLL fixes for 4.3-rc2
In-Reply-To: <20150916223051.GO23081@codeaurora.org>
References: <1442389379-9298-1-git-send-email-gabriel.fernandez@linaro.org>
 <20150916223051.GO23081@codeaurora.org>
Message-ID: <55FA8C14.3020000@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/17/2015 12:30 AM, Stephen Boyd wrote:
> On 09/16, Gabriel Fernandez wrote:
>> This patch set fixes a kernel crash :
> [..]
>> This kernel crash is due to a broken compatibility with this commit:
>> commit 5eb26c605909 ("ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x")
> It isn't clear who's supposed to apply this because the To: list
> is huge. Did you want to take this through arm-soc? If so, feel
> free to take my acked-by on the second patch. The first patch
> doesn't even apply to clk tree because the patch introducing the
> typo didn't go through our tree.
Indeed Stephen, I see it went through my tree (STi DT).
So the first patch should be taken through arm-soc.
The second patch, should be taken through yours I think.

Regards,
Maxime
