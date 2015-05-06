From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 May 2015 11:39:58 +0200
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <20150501234214.GK12076@piout.net>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <20150501234214.GK12076@piout.net>
Message-ID: <2694895.MomHLoCaoZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 May 2015 01:42:14 Alexandre Belloni wrote:
> Hi,
> 
> On 14/12/2010 at 16:08:26 +0100, Hans Ulli Kroll wrote :
> > driver for the rtc device
> > on Cortina Systems CS3516 or StormlinkSemi SL3516 aka Gemini SoC
> > 
> > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> 
> This driver has never been merged and the platform doesn't seem to be
> active anymore. Is there still any interest in getting this driver
> mainlined?
> 
> Only tree wide cleanups happened in mach-gemini since end of 2010, the
> listed git repository (git://git.berlios.de/gemini-board) was on berliOS
> (closed since 2011) and the sourceforge mirror seems empty. Is there
> still interest in keeping that platform in the mainline?

As far as I know, the platform is still used by a number of people,
and is supported by OpenWRT. The reason we haven't seen updates is that
Ulli has been mostly absent from upstream development, and we haven't
had any other person step up as maintainer.

I have a patch to convert the platform to ARCH_MULTIPLATFORM, and
the code doesn't really get in the way otherwise.

As far as I'm concerned, we should just merge all the patches from
http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches-3.18

We should also try to find a maintainer that can respond to patches
in a timely manner. If Ulli has time for that again, that would be great,
otherwise I think we should find someone from OpenWRT to take over.

	Arnd
