From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Fri, 8 Jan 2016 08:56:36 +0100
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160108022619.GS12777@atomide.com>
References: <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
 <20160106174039.GA14271@earth> <20160106174713.GL12777@atomide.com>
 <568D5669.4040801@gmail.com> <20160106182650.GM12777@atomide.com>
 <568D5F54.7040900@gmail.com> <20160107180700.GN12777@atomide.com>
 <568EDC8D.7070205@gmail.com> <20160108022619.GS12777@atomide.com>
Message-ID: <20160108075636.GM11364@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 January 2016 18:26:20 Tony Lindgren wrote:
> > The problem is that between NOLO and kernel there is u-boot. And even if I
> > am almost sure it doesn't touch onenand configs, I can't be absolutely sure.
> > So those timings are not 100% reliable IMO, though close to that.
> 
> Hmm yes I'm only booting with u-boot here as my device sits in my rack.

U-boot try to configure N900 device similar like (some older version of)
linux kernel. So testing these bugs should be done also directly from
NOLO without U-boot.

Btw, if you have usb connection to your device in your rack, you can use
0xFFFF tool (open source) which can send kernel image to NOLO which will
boot it without flashing NAND.

https://github.com/pali/0xFFFF

Original Nokia flasher-3.5 could support also serial connection (not
only usb), but do not know. I have never used serial connector on my
N900, so I do not know and this is reason why also 0xFFFF has no serial
support...

-- 
Pali Roh?r
pali.rohar at gmail.com
