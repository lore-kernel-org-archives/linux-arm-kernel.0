From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:17:05 -0500
Subject: [PATCH v3 3/4] dt-bindings: rtc: update stm32-rtc documentation
 for stm32mp1 rtc
In-Reply-To: <1526558666-24243-4-git-send-email-amelie.delaunay@st.com>
References: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
 <1526558666-24243-4-git-send-email-amelie.delaunay@st.com>
Message-ID: <20180522171705.GA22550@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 02:04:25PM +0200, Amelie Delaunay wrote:
> RTC embedded in stm32mp1 SoC is slightly different from stm32h7 one, it
> doesn't require to disable backup domain write protection, and rtc_ck
> parent clock assignment isn't allowed.
> To sum up, stm32mp1 RTC requires 2 clocks, pclk and rtc_ck, and an RTC
> alarm interrupt.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 ++++++++++++++++------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
