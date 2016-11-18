From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 18 Nov 2016 13:50:09 +0200
Subject: [GIT PULL 2/3] ARM64: dts: exynos: DT for v4.10
In-Reply-To: <20161118015954.GP8578@localhost>
References: <1478629589-7520-1-git-send-email-krzk@kernel.org>
 <1478629589-7520-4-git-send-email-krzk@kernel.org>
 <20161118015954.GP8578@localhost>
Message-ID: <20161118115009.GA17239@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 05:59:54PM -0800, Olof Johansson wrote:
> On Tue, Nov 08, 2016 at 08:26:29PM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Exynos5433 + two boards using it. Mobile boards! :)
> > 
> > I am really happy to push it. I know that it has been a lot of effort
> > in Samsung to mainline this.
> > 
> > Best regards,
> > Krzysztof
> > 
> > 
> > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> > 
> >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.10
> > 
> > for you to fetch changes up to 8ac46fc57df82efbc19194dddd335b6c7a960c31:
> > 
> >   arm64: dts: exynos: Add dts file for Exynos5433-based TM2E board (2016-11-03 22:19:57 +0200)
> > 
> > ----------------------------------------------------------------
> > Finally, I am really pleased to announce adding support for Exynos5433 ARMv8
> > SoC along with two boards.  A lot of Samsung people contributed into this
> > but the final work and commits were done by Chanwoo Choi.
> > 
> > This means that for v4.10 we got:
> > 1. Exynos5433 DTSI.
> > 2. Two boards: TM2 and TM2E.  These are (almost fully) working mobile phones.
> 
> Awesome! Looks like TM2 is a Tizen reference board? Great to see the support,
> even if it's taken a while.

Yes, I think these were planned to be reference devices. Userspace
packages and snapshots are published for some quite long time
(http://download.tizen.org/snapshots/tizen/3.0-mobile/latest/images/arm64-wayland/).

Best regards,
Krzysztof
