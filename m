From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 25 Jan 2011 13:58:23 -0800
Subject: [PATCH 4/4] msm: clock: Add support for more proc_comm clocks
In-Reply-To: <1295927118-27591-5-git-send-email-sboyd@codeaurora.org>
References: <1295927118-27591-1-git-send-email-sboyd@codeaurora.org>
	<1295927118-27591-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <1295992703.25496.72.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-24 at 19:45 -0800, Stephen Boyd wrote:
> Support the CE_CLK and CODEC_SSBI_CLK. Also add support for uart,
> and i2c clocks on targets which support proc_comm clocks.

Basically when you catch yourself writing "also" in the commit text you
need to re-evaluate making two patches.. In this case it looks
appropriate..

I'd do CE_CLK and CODEC_SSBI_CLK in one, with the increment for the
number of clocks, and adding those two clocks.

Then the rest of it I'm not sure. If it was me I'd break out uart and
i2c in different patches but that might be overkill.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
