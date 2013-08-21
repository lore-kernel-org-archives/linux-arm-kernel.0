From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Aug 2013 11:53:50 +0100
Subject: [PATCH 0/3] ARM: vexpress_defconfig: Allow to boot using a
 regular filesystem on SD card
In-Reply-To: <1377082313.10707.11.camel@hornet>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
 <1377075956.3591.23.camel@linaro1.home> <1377082313.10707.11.camel@hornet>
Message-ID: <20130821105350.GM17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 11:51:53AM +0100, Pawel Moll wrote:
> This gets down to the question do we actually want the
> vexpress_defconfig at all? I was considering removing it completely as
> multi_v7_defconfig should do the job (potentially subject to an extra
> config option or two), but if there really is a need for vexpress-only
> one, I can take the changes and queue it for the next-next merge window.

The removal of that configuration will break two of the nightly builds
I run.
