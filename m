From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Thu, 17 Apr 2014 13:38:03 -0700
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <CADHgK6vyWU1HCueN=F5D0JxzknV==h-jOG9JmcXeOrH_RGV4JQ@mail.gmail.com>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140416101243.GA6952@n2100.arm.linux.org.uk>
 <CADHgK6vyWU1HCueN=F5D0JxzknV==h-jOG9JmcXeOrH_RGV4JQ@mail.gmail.com>
Message-ID: <CADHgK6v43=KSpe2FRG374nbHSMOt9hb+xEhO7z20vhEAQsx0tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

It seems to work fine with your virt_to_phys on the 3.13 + OMAP
patches kernel, and I checked on the 3.15-rc1 kernel + hibernation and
it compiled and ran fine.  I tried a couple of hibernations on this
version as well and they worked (aside from the crash in kernel_halt
we're discussing separately).  I believe this just works by chance
though because the omap platform has no real hibernation support
there.

I'll try now to merge up the omap patches to 3.15-rc1.

Thanks,

Sebastian
