From: kwestfie@codeaurora.org (Ken Westfield)
Date: Thu, 22 Jan 2015 13:41:22 -0800
Subject: [PATCH v3 0/8] qcom audio clock control drivers
In-Reply-To: <1421719535-28398-1-git-send-email-sboyd@codeaurora.org>
References: <1421719535-28398-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150122214121.GA23451@kwestfie-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 06:05:27PM -0800, Stephen Boyd wrote:
> This patchset adds support for the low power audio subsystem (LPASS)
> clock controller hardware. I split out the #define patch for IPQ so that
> it can go through the clock tree and the arm-soc tree in parallel
> if desired.

Verified all supported bit clock frequencies for audio playback work on
the ipq806x SOC with max98357a codec.

Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
