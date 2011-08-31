From: davidb@codeaurora.org (David Brown)
Date: Tue, 30 Aug 2011 21:25:32 -0700
Subject: [GIT PULL] msm: devboard defconfigs
In-Reply-To: <alpine.LFD.2.00.1108302021530.20358@xanadu.home>
References: <20110830225213.GB7093@huya.qualcomm.com>
	<alpine.LFD.2.00.1108302021530.20358@xanadu.home>
Message-ID: <20110831042532.GA14892@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 08:23:21PM -0400, Nicolas Pitre wrote:
> On Tue, 30 Aug 2011, David Brown wrote:
> 
> > Unless Russell objects, and prefers these to be in his tree, I'm fine
> > with having these in a branch for linux-next that isn't merged
> > upstream for now.
> > 
> > The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:
> > 
> >   Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
> > 
> > are available in the git repository at:
> >   git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-defconfig
> > 
> > David Brown (1):
> >       ARM: msm: defconfigs for Qualcomm dev boards
> > 
> >  arch/arm/configs/msm7x30_defconfig |   68 +++++++++
> >  arch/arm/configs/msm8660_defconfig |   96 +++++++++++++
> >  arch/arm/configs/msm8960_defconfig |  265 ++++++++++++++++++++++++++++++++++++
> >  arch/arm/configs/qsd8x50_defconfig |   82 +++++++++++
> 
> What prevents you from merging them together?
> Can't you build a single kernel binary with support for allMSM targets?

Not yet, still a good bunch of things that need to happen before that
can be done.  I'm not even sure it's going to be possible before
device tree, since the memory block where I read to determine which
CPU I'm on differs from platform to platform.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
