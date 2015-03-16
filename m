From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 08:44:10 -0700
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <20150302112836.GA27317@amd>
References: <201502271645.58765@pali>
 <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
 <20150302112836.GA27317@amd>
Message-ID: <20150316154409.GQ5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [150302 03:32]:
> On Fri 2015-02-27 16:55:26, Pali Roh?r wrote:
> > This patch adds support for DT "/revision" and convert ATAG_REVISION to DT.
> > 
> > Pali Roh?r (2):
> >   arm: devtree: Set system_rev from DT revision
> >   arm: boot: convert ATAG_REVISION to DT revision field
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Are these queued somewhere now? Sounds like this is the last pending
issue for n900 to use legacy user space with current mainline kernels,
so I'd like to get these in so we can get closer to making omap3 boot
in device tree only mode.

Regards,

Tony
