From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 25 Jan 2011 14:02:17 -0800
Subject: [PATCH 1/4] msm: clock: Remove unused code and definitions
In-Reply-To: <4D3F4609.3000808@codeaurora.org>
References: <1295927118-27591-1-git-send-email-sboyd@codeaurora.org>
	<1295927118-27591-2-git-send-email-sboyd@codeaurora.org>
	<1295991537.25496.49.camel@c-dwalke-linux.qualcomm.com>
	<4D3F4609.3000808@codeaurora.org>
Message-ID: <1295992937.25496.75.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-25 at 13:52 -0800, Saravana Kannan wrote:
> On 01/25/2011 01:38 PM, Daniel Walker wrote:
> > On Mon, 2011-01-24 at 19:45 -0800, Stephen Boyd wrote:
> >> Remove dead code and push out clock-7x30.h and clock-pcom.h to
> >> where they are actually used.
> >>
> >
> > I'd do two patches for this. The stuff your doing is too disconnected.
> >
> > Daniel
> >
> There is a whole bunch of unused code in the clock files and it's being 
> deleted. I don't see a point of splitting it up per file.

It's easier to review when changes aren't merged that don't related to
each other.

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
