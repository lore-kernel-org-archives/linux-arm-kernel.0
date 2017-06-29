From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jun 2017 20:19:27 +0530
Subject: [RFC 1/5] drivers: Add boot constraints core
In-Reply-To: <20170629125040.GW4902@n2100.armlinux.org.uk>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <24921f2a6a86cb9b2b3a1cae86649180bc116a62.1498642745.git.viresh.kumar@linaro.org>
 <78941b27-c233-837d-9709-b11c01f1ab1f@infradead.org>
 <20170629035157.GG29665@vireshk-i7>
 <20170629125040.GW4902@n2100.armlinux.org.uk>
Message-ID: <20170629144927.GP29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-17, 13:50, Russell King - ARM Linux wrote:
> On Thu, Jun 29, 2017 at 09:21:57AM +0530, Viresh Kumar wrote:
> > On 28-06-17, 08:55, Randy Dunlap wrote:
> > > On 06/28/2017 03:26 AM, Viresh Kumar wrote:
> > 
> > > > +config BOOT_CONSTRAINTS
> > > > +	bool "Boot constraints for devices"
> > > > +	default y
> > > 
> > > Why default y?
> > > 
> > > As Linus just wrote yesterday:
> > > 
> > > No. We've tried. The only sensible default (and that I try to enforce)
> > > is "new featrures default to 'n'"
> > 
> > Yeah, this should have been n really.
> 
> Given that the default default is to default to n, you don't need to
> supply a default that just says what the default default actually is.
> Please also avoid silly defaults.

That was nice :)

Yeah, will get rid of the default statement here.

-- 
viresh
