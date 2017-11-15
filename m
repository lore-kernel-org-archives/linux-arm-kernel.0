From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Nov 2017 16:16:46 -0800
Subject: [PATCH 7/8] clk: mediatek: mt8173-mm: switch to mfd device
In-Reply-To: <20171114214114.15793-8-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-8-mbrugger@suse.com>
Message-ID: <20171115001646.GI11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14, Matthias Brugger wrote:
> As the new mfd device is in place, switch probing
> for the MMSYS to support invocation from the mfd device.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
