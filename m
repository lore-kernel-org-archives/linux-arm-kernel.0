From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 26 Jan 2011 14:04:39 -0800
Subject: [PATCH 4/4] msm: clock: Add support for more proc_comm clocks
In-Reply-To: <8yawrlr726g.fsf@huya.qualcomm.com>
References: <1295927118-27591-1-git-send-email-sboyd@codeaurora.org>
	<1295927118-27591-5-git-send-email-sboyd@codeaurora.org>
	<1295992703.25496.72.camel@c-dwalke-linux.qualcomm.com>
	<8yawrlr726g.fsf@huya.qualcomm.com>
Message-ID: <1296079479.29801.46.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-26 at 14:03 -0800, David Brown wrote:
> On Tue, Jan 25 2011, Daniel Walker wrote:
> 
> > On Mon, 2011-01-24 at 19:45 -0800, Stephen Boyd wrote:
> >> Support the CE_CLK and CODEC_SSBI_CLK. Also add support for uart,
> >> and i2c clocks on targets which support proc_comm clocks.
> >
> > Basically when you catch yourself writing "also" in the commit text you
> > need to re-evaluate making two patches.. In this case it looks
> > appropriate..
> 
> Or it is just an argument to not use the word also in the commit text.
> I don't think it's really necessary to split up a patch that adds a few
> clocks to the clock table.

This one it actually makes a lot of sense to break it up. He's doing
some very different things here all in the same patch ..

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
