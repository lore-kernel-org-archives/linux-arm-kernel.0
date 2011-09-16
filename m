From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 16 Sep 2011 12:27:54 +0200
Subject: READ THIS: the next mach-types update
In-Reply-To: <20110915102528.GI6267@n2100.arm.linux.org.uk>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk>
Message-ID: <20110916102754.GA6205@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 11:25:28AM +0100, Russell King - ARM Linux wrote:
> -devixp                  MACH_DEVIXP             DEVIXP                  2885
> -miccpt                  MACH_MICCPT             MICCPT                  2886
> -mic256                  MACH_MIC256             MIC256                  2887

Russell,

I had posted support for these some time ago, and shortly thereafter
the whole "clean up the ARM mess" campaign started. I did not follow
up on posting a second time, for fear of adding more churn.

So, my question is, what can I do to keep these in the list?

Can I get plain old board setup files merged (like three of the
following) ...

 arch/arm/mach-ixp4xx/Kconfig                   |    8 +
 arch/arm/mach-ixp4xx/Makefile                  |    2 +
 arch/arm/mach-ixp4xx/include/mach/uncompress.h |    2 +-
 arch/arm/mach-ixp4xx/miccpt-pci.c              |   78 +++++++++
 arch/arm/mach-ixp4xx/miccpt-setup.c            |  219 ++++++++++++++++++++++++
 5 files changed, 308 insertions(+), 1 deletions(-)

or would I have to somehow upgrade to DT?

Thanks,

Richard
