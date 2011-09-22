From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Sep 2011 17:32:58 +0100
Subject: [PATCH 1/3] arm/tegra: Move EN_VDD_1V05_GPIO to board-harmony.h
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1739554CBD@HQMAIL01.nvidia.com>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
	<CAOesGMisOtEQpcS-hHi-3brpYzJr-UiB6b71c+bwkesPDk9iuA@mail.gmail.com>
	<20110922081140.GH17169@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF1739554CBD@HQMAIL01.nvidia.com>
Message-ID: <20110922163258.GD8072@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 09:31:48AM -0700, Stephen Warren wrote:
> Russell King - ARM Linux wrote at Thursday, September 22, 2011 2:12 AM:
> > On Wed, Sep 21, 2011 at 01:16:49PM -0700, Olof Johansson wrote:
> > > Works for me. Or I could stage it in a topic branch that would be
> > > merged after Russell's GPIO tree.
> > 
> > Holding stuff off from being merged doesn't work.
> 
> Russell,
> 
> So I take it I should add the two ack'd patches to the ARM patch system,
> and have you pick them up?

That's a workable solution, yes.  I've done that with various other
gpio patches from people, and Grant seems happy with that.
