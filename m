From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 19:52:55 +0100
Subject: [PATCH 20/24] msm: MSM8X60 simulator board support
In-Reply-To: <20100902181914.GB2589@huya.qualcomm.com>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-21-git-send-email-johlstei@codeaurora.org>
	<20100902111310.GY26319@n2100.arm.linux.org.uk>
	<20100902181914.GB2589@huya.qualcomm.com>
Message-ID: <20100902185255.GA26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 11:19:14AM -0700, David Brown wrote:
> On Thu, Sep 02, 2010 at 12:13:10PM +0100, Russell King - ARM Linux wrote:
> 
> > > +config MACH_MSM8X60_SIM
> > > +	depends on ARCH_MSM8X60
> > > +	default n
> > 
> > All these 'default n' statements can be removed - n is the default anyway.
> 
> Isn't the behavior different, though?  If I do a 'make oldconfig'
> after a kernel upgrade, new options that don't have defaults will stop
> and prompt me, whereas ones with a listed default will just select the
> default without asking.

You always get asked about new options which have an option text - but
'default' sets what you get when you just hit 'enter' on them.
