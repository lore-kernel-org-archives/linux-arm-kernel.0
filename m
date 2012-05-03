From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 3 May 2012 18:13:16 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <4FA2B98A.6060800@linaro.org>
References: <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org>
 <20120425185747.GC24211@n2100.arm.linux.org.uk>
 <4FA29E46.6040204@linaro.org>
 <20120503151253.GE897@n2100.arm.linux.org.uk>
 <4FA2A4A8.9010208@linaro.org>
 <20120503163008.GF897@n2100.arm.linux.org.uk>
 <4FA2B4A3.2040402@linaro.org>
 <20120503164501.GG897@n2100.arm.linux.org.uk>
 <4FA2B98A.6060800@linaro.org>
Message-ID: <20120503171316.GD14296@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 05:59:54PM +0100, Lee Jones wrote:
> On 03/05/12 17:45, Russell King - ARM Linux wrote:

> >One thing that might help is if the format of these descriptions were
> >changed so that there was one file per subsystem documenting the common
> >options, rather than (eg) every MMC driver documentating the same base
> >options time and time again.

> I'm afraid that's not really for me to decide, however Grant is on
> CC. Perhaps that's a point he'd like to drive. If he's stopped
> reading this thread and fails to reply, I will endeavor to poke him
> about it while we're in Hong Kong.

It's what we're already doing for other things where there's a lot of
commonality like regulators, I don't think there's any conroversy, it's
just reminding people to not cut'n'paste.
