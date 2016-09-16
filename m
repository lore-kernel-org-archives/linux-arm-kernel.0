From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2016 16:03:00 -0700
Subject: [PATCH v3 04/14] drivers: clk: st: Add fs660c32 synthesizer
 algorithm
In-Reply-To: <1472473626-15398-5-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
 <1472473626-15398-5-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20160916230300.GP7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Use an algorithm instead of a table to compute clocks for fs660c32
> synthesizer.
> During a video playback we need to adjust audio & video frequencies.
> A table can't cover all HDMI resolutions and audio adjustment.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
