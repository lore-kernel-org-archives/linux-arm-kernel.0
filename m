From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 12 Jan 2015 14:37:50 -0800
Subject: [GIT PULL] Xilinx Zynq dt fixes for v3.19
In-Reply-To: <20150112220057.GA22090@quad.lixom.net>
References: <544519A4.5090003@monstr.eu> <54AE44AF.6010808@monstr.eu>
 <20150112220057.GA22090@quad.lixom.net>
Message-ID: <4fa414c23aa94471a0e6ff9e06b28da1@BY2FFO11FD051.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-12 at 02:00PM -0800, Olof Johansson wrote:
> On Thu, Jan 08, 2015 at 09:49:51AM +0100, Michal Simek wrote:
> > Hi,
> > 
> > please consider to pull this one DT patch to your tree as fix for v3.19
> > It is adding USD dt node. Driver has been added to v3.19.
> > 
> > Thanks,
> > Michal
> > 
> > The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> > 
> >   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-fixes-for-3.19
> > 
> > for you to fetch changes up to 1643b31658c44767a85469733c6bff4f6d0371c7:
> > 
> >   ARM: zynq: DT: Add USB to device tree (2015-01-08 09:35:04 +0100)
> 
> Michal,
> 
> This isn't really a fix for something that is broken, is it? I.e. looks like
> new hardware support to me, and unfortunately this time in the release is wrong
> for that.

Without it, USB is broken/not working on Zynq :P
It just came a little late due to the holidays. Would be nice if it
could still make it, since the driver is available now and the DT
fragment is the only missing piece to provide out-of-the-box USB
support.
	
	Soren
