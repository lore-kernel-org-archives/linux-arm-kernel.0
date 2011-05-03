From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 02 May 2011 19:46:28 -0700
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <4DBF6C08.90902@codeaurora.org>
References: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>	<alpine.LFD.2.02.1104201704350.3323@ionos>	<20110420185922.GD31131@pengutronix.de>	<alpine.LFD.2.02.1104202113250.3323@ionos>	<20110421072259.GG31131@pengutronix.de>	<alpine.LFD.2.02.1104211045220.3323@ionos>	<20110429103723.GF5126@n2100.arm.linux.org.uk>	<alpine.LFD.2.02.1104291252080.3005@ionos>	<20110429110610.GJ5126@n2100.arm.linux.org.uk>	<alpine.LFD.2.02.1104291344020.3005@ionos>	<20110429132613.GL5126@n2100.arm.linux.org.uk>
	<4DBF6C08.90902@codeaurora.org>
Message-ID: <4DBF6C84.8020506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2011 07:44 PM, Saravana Kannan wrote:
> I think Thomas mostly cares about having the tree handling done at the
> core code level. Russell's main point seems to be that the parent can
> change for reasons other than "clk_set_parent()" and hence we can have
> the core code manage all of the parent handling.

Typo. Meant to say:
and hence we can't have the core code manage all of the parent handling.

-Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
