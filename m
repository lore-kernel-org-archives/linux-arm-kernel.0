From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 24 Aug 2015 11:45:02 +0200
Subject: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
In-Reply-To: <55DAE15B.6090602@xilinx.com>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net> <55DACC5A.80707@xilinx.com>
 <20150824080800.GG13155@piout.net> <55DAE15B.6090602@xilinx.com>
Message-ID: <20150824094502.GI13155@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2015 at 11:18:19 +0200, Michal Simek wrote :
> > I'm not fond of carrying patches with uncontactable authors. Is that a
> > permanent error?
> 
> Unfortunately. That guy left Xilinx last week but don't be scared that
> none will be responsible about this driver. I have well proven history
> on Linux and others project and I am here if you need to do some testing
> or ACK for changes. Just let me know when you need something.
> 
> get_maintainer returns me and Soren that's why you shouldn't have any
> problem with it.
> 
> [linux]$ ./scripts/get_maintainer.pl -f drivers/rtc/rtc-zynqmp.c
> Alessandro Zummo <a.zummo@towertech.it> (maintainer:REAL TIME CLOCK
> (RTC) SUBSYSTEM)
> Alexandre Belloni <alexandre.belloni@free-electrons.com>
> (maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM)
> Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)
> "S?ren Brinkmann" <soren.brinkmann@xilinx.com> (reviewer)
> rtc-linux at googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
> linux-arm-kernel at lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE)
> linux-kernel at vger.kernel.org (open list)
> 

Perfect, thanks!


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
