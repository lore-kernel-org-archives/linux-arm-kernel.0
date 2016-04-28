From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Apr 2016 13:31:57 +0100
Subject: [PATCH] arm64: Drop CONFIG_RTC_LIB dependency
In-Reply-To: <5680660.CkYB5IbEDj@wuerfel>
References: <1461776128-7808-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <20160428122424.GG24693@arm.com> <5680660.CkYB5IbEDj@wuerfel>
Message-ID: <20160428123156.GB30834@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 02:29:34PM +0200, Arnd Bergmann wrote:
> On Thursday 28 April 2016 13:24:25 Will Deacon wrote:
> > On Wed, Apr 27, 2016 at 01:55:28PM -0300, Ezequiel Garcia wrote:
> > > The rtc-lib dependency is not required, and seems it was just
> > > copy-pasted from ARM's Kconfig. If platform requires rtc-lib,
> > > they should select it individually.
> > 
> > Are you sure this doesn't break any platforms that are relying on this
> > implicit select?
> > 
> 
> I have checked this carefully. I actually had a patch that removed this
> from all of the kernel, but then found some users on other architectures.
> ARM and ARM64 both don't use it.

Great, thanks Arnd. Can I add your reviewed-by to this patch then, please?

Will
