From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 07 Feb 2011 09:36:20 -0800
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <20110204133556.GA2803@ucw.cz>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
	<20110204133556.GA2803@ucw.cz>
Message-ID: <1297100180.11955.1.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-04 at 14:36 +0100, Pavel Machek wrote:
> On Thu 2011-01-20 12:32:38, Daniel Walker wrote:
> > This series adds basic Nexus One support which includes a booting
> > kernel, and functional MMC .
> > 
> > Most people won't be able to use this yet unfortunately because
> > you need a serial cable to get any output. However, it's a start.
> 
> >   msm: mahimahi: add mahimahi board file
> >   msm: mahimahi: add in mmc support code
> >   msm: mahimahi: add gpio pin muxing code
> >   msm: mahimahi: initialize mmc at start up
> 
> Even you call the machine Nexus One... can  you be a tiny bit more
> consistent with it?

I tried to call it Nexus One in this release note cause no one knows
what a "mahimahi" is .. I would like to call it Nexus One all over, but
I can't because Google uses the name mahimahi..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
