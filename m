From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 11:42:32 +0100
Subject: [PATCH V2 0/5] Huge pages for short descriptors on ARM
In-Reply-To: <20140424103639.GC19564@arm.com>
References: <1397648803-15961-1-git-send-email-steve.capper@linaro.org>
 <20140424102229.GA28014@linaro.org> <20140424103639.GC19564@arm.com>
Message-ID: <20140424104232.GK26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 11:36:39AM +0100, Will Deacon wrote:
> I guess I'm after some commitment that this is (a) useful to somebody and
> (b) going to be tested regularly, otherwise it will go the way of things
> like big-endian, where we end up carrying around code which is broken more
> often than not (although big-endian is more self-contained).

It may be something worth considering adding to my nightly builder/boot
testing, but I suspect that's impractical as it probably requires a BE
userspace, which would then mean that the platform can't boot LE.

I suspect that we will just have to rely on BE users staying around and
reporting problems when they occur.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
