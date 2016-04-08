From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Apr 2016 08:56:09 -0700
Subject: [PATCH 0/3] ARM: OMAP2: Make suspend work again.
In-Reply-To: <5701FFEC.5020008@ti.com>
References: <1459551187-5992-1-git-send-email-nm@ti.com>
 <5701FFEC.5020008@ti.com>
Message-ID: <20160408155609.GU16484@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <a0393675@ti.com> [160403 22:48]:
> 
> 
> On Saturday 02 April 2016 04:23 AM, Nishanth Menon wrote:
> >Hi,
> >series of patches for fixing up attempt to suspend on X15
> >
> >Test: http://pastebin.ubuntu.com/15582436/
> >
> >Based on v4.6-rc1
> >
> >Also needs https://patchwork.kernel.org/patch/8724791/ if kernel
> >modules are installed
> 
> Thanks for the series Nishanth.
> 
> I tested suspend/resume and used no_console_suspend and woke up using uart
> on DRA7-EVM.

Applying all three into omap-for-v4.6/fixes thanks.

Tony
