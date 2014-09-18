From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Sep 2014 21:04:54 -0400 (EDT)
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <20140917152735.GU12361@n2100.arm.linux.org.uk>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
 <20140910145818.GG12361@n2100.arm.linux.org.uk>
 <1410363657.23973.48.camel@hornet>
 <20140917152735.GU12361@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1409172059050.8647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Sep 2014, Russell King - ARM Linux wrote:

> As for TC2, I just don't bother with that.  It's really not worth the
> hastle.  I asked for help with that and got almost nothing.  Yes, there's
> Nicolas' uboot, which solves some problems, but getting the kernel to
> boot on TC2 turned out to be a dead loss - and no help with it was
> forthcoming.

TC2 is my main development board at the moment and it boots mainline 
perfectly.  If you want I can provide you with a tarball of everything 
you need to boot it, including my setup script and compiled kernel, to 
get you started.


Nicolas
