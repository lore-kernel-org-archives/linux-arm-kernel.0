From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Aug 2014 16:54:43 +0800
Subject: [PATCH V2 4/4] ARM: dts: i.MX53: Add PMU DT entry
In-Reply-To: <53E33208.8020607@parkeon.com>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144840.25462.57101.stgit@localhost> <20140806105048.GF25953@arm.com>
 <53E22F35.4060503@parkeon.com> <20140807055301.GD27051@dragon>
 <53E33208.8020607@parkeon.com>
Message-ID: <20140807085442.GA26680@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 10:00:08AM +0200, Martin Fuzzey wrote:
> On 07/08/14 07:53, Shawn Guo wrote:
> >On Wed, Aug 06, 2014 at 03:35:49PM +0200, Martin Fuzzey wrote:
> >>On 06/08/14 12:50, Will Deacon wrote:
> >>>
> >>>You're missing the new property.
> >>Actually this was deliberate.
> >>
> >>Since the property should only be used if booting in secure mode
> >>this generic dtsi file can't know if it is ok or not.
> >As far as I know, most of the i.MX53 systems boot Linux kernel in secure
> >mode.  In that case, we should probably have the new property by
> >default?
> 
> Is it possible to override a boolean property to remove it (set to
> false) in a board specific dts?
> 
> If it can be done then yes I agree it should be the default.
> 
> However seeing as the dts syntax doesn't give a value for boolean
> properties I don't see how.
> 
> But I don't think people booting non secure should have to modify imx53.dtsi

Ah, yes.  I missed the fact that the property is a boolean.

Shawn
