From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 24 Aug 2015 10:08:00 +0200
Subject: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
In-Reply-To: <55DACC5A.80707@xilinx.com>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net> <55DACC5A.80707@xilinx.com>
Message-ID: <20150824080800.GG13155@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2015 at 09:48:42 +0200, Michal Simek wrote :
> On 08/24/2015 09:43 AM, Alexandre Belloni wrote:
> > On 19/08/2015 at 15:23:22 +0530, Suneel Garapati wrote :
> >> adds support for RTC controller found on
> >> Xilinx Zynq Ultrascale+ MPSoC platform.
> >>
> >> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
> >> ---
> >> Changes v3 
> >> - fix checkpatch errors 
> >> - check time in secs arg against max sec val 
> >> - order header files 
> >> - use ptr_err_or_zero macro 
> >> - use time64 variants 
> >> Changes v2 
> >> - change alm to alarm 
> >> ---
> >>  drivers/rtc/Kconfig      |   7 ++
> >>  drivers/rtc/Makefile     |   1 +
> >>  drivers/rtc/rtc-zynqmp.c | 279 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 287 insertions(+)
> >>  create mode 100644 drivers/rtc/rtc-zynqmp.c
> >>
> > Applied, thanks.
> > 
> 

Actually, I got the following message:
A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  suneel.garapati at xilinx.com
    Unknown User

I'm not fond of carrying patches with uncontactable authors. Is that a
permanent error?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
