From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Jan 2017 11:33:12 -0800
Subject: [PATCH v4 1/9] clk: stm32f4: Update DT bindings documentation
In-Reply-To: <ccd14adb-9d10-ae9e-de6d-565418421968@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-2-git-send-email-gabriel.fernandez@st.com>
 <20161222001051.GP8288@codeaurora.org>
 <ccd14adb-9d10-ae9e-de6d-565418421968@st.com>
Message-ID: <20170109193312.GN17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09, Alexandre Torgue wrote:
> Hi Stephen,
> 
> On 12/22/2016 01:10 AM, Stephen Boyd wrote:
> >On 12/13, gabriel.fernandez at st.com wrote:
> >>From: Gabriel Fernandez <gabriel.fernandez@st.com>
> >>
> >>Creation of dt include file for specific stm32f4 clocks.
> >>These specific clocks are not derived from system clock (SYSCLOCK)
> >>We should use index 1 to use these clocks in DT.
> >>e.g. <&rcc 1 CLK_LSI>
> >>
> >>Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> >>Acked-by: Rob Herring <robh@kernel.org>
> >>---
> >
> >Applied to clk-stm32f4 and merged into clk-next.
> >
> 
> I'm preparing pull request branch for STM32 DT part. This patch is
> also requested to build correctly DT patches. Do you know how could
> we synchronize our pull request ?
> 

clk-stm32f4 is stable and not going to be rebased, so you're good
to base patches on it and send it off to arm-soc if the arm-soc
maintainers agree to it. You can also base off an earlier part of
the branch if you only need this first patch for example.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
