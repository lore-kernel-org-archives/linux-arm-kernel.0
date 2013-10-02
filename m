From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 Oct 2013 17:02:26 +0900
Subject: [PATCH 00/03] ARM: shmobile: Initial r7s72100 SoC and Genmai
 board support
In-Reply-To: <CANqRtoRmNxDYxTz=onmuRK2qhqwn+gb0Cb+-Ot+EB9FervCJ6A@mail.gmail.com>
References: <20130918201101.6319.97667.sendpatchset@w520>
 <20130925043913.GA23347@verge.net.au>
 <CANqRtoRmNxDYxTz=onmuRK2qhqwn+gb0Cb+-Ot+EB9FervCJ6A@mail.gmail.com>
Message-ID: <20131002080222.GA28462@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 03:07:41PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Sep 25, 2013 at 1:39 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Sep 19, 2013 at 05:11:01AM +0900, Magnus Damm wrote:
> >> ARM: shmobile: Initial r7s72100 SoC and Genmai board support
> >>
> >> [PATCH 01/03] ARM: shmobile: Initial r7s72100 SoC support
> >> [PATCH 02/03] ARM: shmobile: r7s72100 SCIF support
> >> [PATCH 03/03] ARM: shmobile: Genmai support
> >>
> >> This series adds initial support for r7s72100 and Genmai. The SoC
> >> is known as r7s72100 which is based on a single core Cortex-A9
> >> and makes use of SCIF for serial. Many other on-chip I/O devices
> >> are available, and support for those will be added by incremental
> >> feature patches.
> >>
> >> This initial SoC and board support is providing limited DT-only
> >> support and a very basic C-version of board support. In the future
> >> improved PINCTRL and common clock framework support will be added.
> >>
> >> Implemented in same style as r8a7790 and r8a7791.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >
> > Hi Magnus,
> >
> > please provide a defconfig if you would like this series merged.
> > Otherwise this seems reasonable to me.
> 
> Thanks, yes, I'd like to see this series merged.
> 
> Please use the recently posted defconfig in:
> 
> [PATCH] ARM: shmobile: Genmai defconfig

Thanks, I see it.
