From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 03 Sep 2010 09:23:22 -0700
Subject: [PATCH 14/24] msm: add hotplug stub functions
In-Reply-To: <20100903073135.GD26319@n2100.arm.linux.org.uk>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-15-git-send-email-johlstei@codeaurora.org>
	<20100902111157.GX26319@n2100.arm.linux.org.uk>
	<1283446177.3674.0.camel@c-dwalke-linux.qualcomm.com>
	<20100902171253.GX26319@n2100.arm.linux.org.uk>
	<1283467000.3674.381.camel@c-dwalke-linux.qualcomm.com>
	<20100903073135.GD26319@n2100.arm.linux.org.uk>
Message-ID: <1283531002.14338.1.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-09-03 at 08:31 +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 02, 2010 at 03:36:40PM -0700, Daniel Walker wrote:
> > If no others use it .. We can do this to fix them all. What do you
> > think?
> 
> If no one else implements it, then you can't suspend, nor can you
> support kexec.  (We should update Kconfig to add this as a dependency.)

I must be wrong then, but I don't see those function anyplace but in
RealView.. Maybe they aren't suspending in SMP yet..

> So if you want these features, you'll need to implement hotplug CPU
> support.

Ok ..

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
