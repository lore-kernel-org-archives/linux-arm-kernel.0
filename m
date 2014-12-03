From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 3 Dec 2014 09:59:50 -0800
Subject: [PATCH v2 0/7] Pinctrl support for Zynq
In-Reply-To: <1417611103.30615.25.camel@mm-sol.com>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417611103.30615.25.camel@mm-sol.com>
Message-ID: <d1b90be2a67942e8a058e27b4cd38e66@BY2FFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-12-03 at 02:51PM +0200, Ivan T. Ivanov wrote:
> 
> On Thu, 2014-11-27 at 17:26 -0800, Soren Brinkmann wrote:
> > Hi all,
> > 
> > here is v2 of this series. 
> 
> Which tree did you use as a base for these patches?
> Tried with pinctrl/devel and linus/master didn't apply.

It's supposed to be pinctrl/devel. And that seems to be mostly true. I
just saw there are two rockchip patches in my branch which shouldn't be.
Guess some rebase went wrong (or the devel branch was rewritten?).
I pushed the series here:
https://github.com/sorenb-xlnx/linux-xlnx/commits/pinctrl

	Thanks,
	S?ren
