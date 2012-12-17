From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 17 Dec 2012 13:18:18 -0800
Subject: [PATCH 1/2] arm: tegra: Add new DT property to USB node.
In-Reply-To: <50CF89AF.3000308@wwwdotorg.org>
References: <1355468348-8821-1-git-send-email-vbyravarasu@nvidia.com>
 <1355468348-8821-2-git-send-email-vbyravarasu@nvidia.com>
 <50CF89AF.3000308@wwwdotorg.org>
Message-ID: <20121217211818.GA20835@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 02:07:59PM -0700, Stephen Warren wrote:
> On 12/13/2012 11:59 PM, Venu Byravarasu wrote:
> > As Tegra USB host driver is using instance number for resetting
> > PORT0 twice, adding a new DT property for handling this.
> 
> Alan, Greg, Felip,e
> 
> This series looks fine to me.
> 
> I'd like to take all the Tegra-related USB patches through the Tegra
> tree for 3.9 if possible (so I'm looking for your acks here). I believe
> Venu plans to significantly clean up the EHCI/PHY driver split for
> Tegra, rework the drivers, and add support for Tegra30 in addition to
> Tegra20. Some of this requires changes to some Tegra board files and
> device trees to maintain "git bisect" I don't know for sure yet, but I
> believe that rework may also end up conflicting with other clock-related
> rework that will show up for Tegra in 3.9. Are you OK with this? I'll
> certainly look for your review/acks on the patches before picking them
> up though.

You can't pick anything up for 3.9 until after 3.8-rc1 is out, according
to the rules of linux-next, so please wait until that kernel is out
before doing anything.  Given the timing of 3.8-rc1, and my current
vacation schedule, I'm not going to be able to do _any_ code review for
the rest of the year, sorry.

After that, I'll be glad to review this.

greg k-h
