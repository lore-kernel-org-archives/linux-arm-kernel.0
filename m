From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 02 Sep 2010 09:49:37 -0700
Subject: [PATCH 14/24] msm: add hotplug stub functions
In-Reply-To: <20100902111157.GX26319@n2100.arm.linux.org.uk>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-15-git-send-email-johlstei@codeaurora.org>
	<20100902111157.GX26319@n2100.arm.linux.org.uk>
Message-ID: <1283446177.3674.0.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-02 at 12:11 +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 24, 2010 at 09:57:43PM -0700, Jeff Ohlstein wrote:
> > From: Daniel Walker <dwalker@codeaurora.org>
> > 
> > We don't actually do anything for hotplug yet. This just lets
> > everything compile, even when hotplug is enabled.
> 
> And the point of that is?  If you're not supporting hotplug CPU yet, then
> don't allow it to be enabled.

How do we do that? I didn't see a easy way to prevent it.

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
