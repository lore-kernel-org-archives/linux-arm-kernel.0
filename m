From: davidb@codeaurora.org (David Brown)
Date: Thu, 2 Sep 2010 11:19:14 -0700
Subject: [PATCH 20/24] msm: MSM8X60 simulator board support
In-Reply-To: <20100902111310.GY26319@n2100.arm.linux.org.uk>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-21-git-send-email-johlstei@codeaurora.org>
	<20100902111310.GY26319@n2100.arm.linux.org.uk>
Message-ID: <20100902181914.GB2589@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 12:13:10PM +0100, Russell King - ARM Linux wrote:

> > +config MACH_MSM8X60_SIM
> > +	depends on ARCH_MSM8X60
> > +	default n
> 
> All these 'default n' statements can be removed - n is the default anyway.

Isn't the behavior different, though?  If I do a 'make oldconfig'
after a kernel upgrade, new options that don't have defaults will stop
and prompt me, whereas ones with a listed default will just select the
default without asking.

I though the desire was to not have it stop and ask unless it really
was something that the user needed to make a decision about.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
