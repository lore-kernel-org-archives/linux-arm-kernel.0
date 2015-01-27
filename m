From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 Jan 2015 11:52:06 -0800
Subject: [PATCH v3 0/8] qcom audio clock control drivers
In-Reply-To: <20150122214121.GA23451@kwestfie-linux.qualcomm.com>
References: <1421719535-28398-1-git-send-email-sboyd@codeaurora.org>
 <20150122214121.GA23451@kwestfie-linux.qualcomm.com>
Message-ID: <20150127195206.22722.54678@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ken Westfield (2015-01-22 13:41:22)
> On Mon, Jan 19, 2015 at 06:05:27PM -0800, Stephen Boyd wrote:
> > This patchset adds support for the low power audio subsystem (LPASS)
> > clock controller hardware. I split out the #define patch for IPQ so that
> > it can go through the clock tree and the arm-soc tree in parallel
> > if desired.
> 
> Verified all supported bit clock frequencies for audio playback work on
> the ipq806x SOC with max98357a codec.
> 
> Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>

Applied to clk-next.

Regards,
Mike

> 
> -- 
> Kenneth Westfield
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> a Linux Foundation Collaborative Project
