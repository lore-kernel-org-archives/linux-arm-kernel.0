From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Feb 2014 17:48:29 +0000
Subject: [PATCH 08/12] mfd: vexpress-sysreg: Add syscon labels as
 platform data
In-Reply-To: <1392139946.3380.48.camel@hornet>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-9-git-send-email-pawel.moll@arm.com>
 <20140211172918.GH15081@lee--X1> <1392139946.3380.48.camel@hornet>
Message-ID: <20140211174829.GJ15081@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Feb 2014, Pawel Moll wrote:

> On Tue, 2014-02-11 at 17:29 +0000, Lee Jones wrote:
> > There must be better
> > ways of passing a name than through pdata, and if there isn't I'd
> > suggest setting up a sysconf pdata struct that others can use in case
> > they wish to expand the functionality further in some other
> > unfathomable way. :)
> 
> ... which I proposed in the previous patch :-)
> 
> > Alternatively I could define a syscon platform data structure,
> > something like this:
> > 
> > struct syscon_platform_data {
> > 	const char *label;
> > };

So you did.

Yes, this would be the lesser of the two evils. 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
