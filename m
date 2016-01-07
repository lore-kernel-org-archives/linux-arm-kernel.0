From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Jan 2016 06:03:07 +0100
Subject: [GIT PULL 3/9] ARM64: EXYNOS: clk: Clock dependency for ARM64
 for v4.5
In-Reply-To: <567A7B10.3030501@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
 <1449020386-20250-4-git-send-email-k.kozlowski@samsung.com>
 <20151222044636.GD30172@localhost> <567A7B10.3030501@samsung.com>
Message-ID: <20160107050307.GA26875@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the slow reply, holidays and vacation and all that.

On Wed, Dec 23, 2015 at 07:44:32PM +0900, Krzysztof Kozlowski wrote:
> W dniu 22.12.2015 o 13:46, Olof Johansson pisze:
> > On Wed, Dec 02, 2015 at 10:39:40AM +0900, Krzysztof Kozlowski wrote:
> >> Hi Kukjin,
> >>
> >> Dependency for soc64 changes.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> >> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> >>
> >>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-arm64-symbols-4.5
> >>
> >> for you to fetch changes up to 8c2a90ed18a74e8b9cdbba679403faa44d6024fc:
> >>
> >>   clk: samsung: Don't build ARMv8 clock drivers on ARMv7 (2015-11-22 19:25:29 +0900)
> > 
> > Hi,
> > 
> > Looks like this lacks ack from any of the clock maintainers.
> 
> It got the ack from Sylwester and Tomasz - Samsung clock maintainers. If
> it is not sufficient... then let's wait with it for v4.6. I am on
> holidays now so I cannot really do anything meaningful with it.

Ok -- even though we have per-driver maintainers, we still look for acks from
the overall subsystem maintainers on these drivers. 

> > Given that EXYNOS_ARM64_COMMON_CLK is not yet introduced, this will cause
> > a breakage in bisectability on some of these platforms as well.
> 
> The patch introduces EXYNOS_ARM64_COMMON_CLK which will be enabled by
> default on our platforms. What kind of breakage do you have in mind?

Ah, I probably missed that.


-Olof
