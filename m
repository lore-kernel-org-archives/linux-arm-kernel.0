From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Mar 2012 09:25:01 +0100
Subject: [GIT PULL 1/5] ARM: cleanups of io includes
In-Reply-To: <1332918842-13521-2-git-send-email-olof@lixom.net>
References: <1332918842-13521-1-git-send-email-olof@lixom.net>
 <1332918842-13521-2-git-send-email-olof@lixom.net>
Message-ID: <20120328082501.GA22414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 12:13:58AM -0700, Olof Johansson wrote:
> Rob Herring has done a sweeping change cleaning up all of the mach/io.h includes,
> moving some of the oft-repeated macros to a common location and removing a bunch of
> boiler plate. This is another step closer to a common zImage for multiple platforms.

NAK.  Linus, do not pull this.  This breaks PXA compilation, which has
been known about for more than a week.
