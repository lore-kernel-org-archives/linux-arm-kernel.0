From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Aug 2015 08:21:38 +0100
Subject: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
In-Reply-To: <55CA8658.80202@codeaurora.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <55CA70D5.6040300@codeaurora.org> <20150811232523.60d192d2@arm.com>
 <55CA78DE.1000306@codeaurora.org> <20150811234801.51108784@arm.com>
 <55CA8658.80202@codeaurora.org>
Message-ID: <20150812082138.6a80c71d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Aug 2015 00:33:44 +0100
Timur Tabi <timur@codeaurora.org> wrote:

> On 08/11/2015 05:48 PM, Marc Zyngier wrote:
> > I don't see any contradiction here. Hanjun picked the patches from my
> > own branch in my own tree, put his own patches on top, and pushed that
> > out on an branch called gsi-irqdomain that is definitely based on
> > 4.2-rc2. I have no idea where your 3.9-rc7 comes from.
> 
> Ok, so that's not your kernel, but the LEG kernel instead.
> 
> The top commits show this:
> 
> Follows: tracking-mainline-llct-20130415.0, 
> tracking-mainline-llct-20130417.0, v3.9-rc7
> 
> Also,
> 	$ git tag | grep v4
> 
> shows no v4.x tags.
> 
> Anyway, I don't want to make a big deal about this.

I just cloned this repository, and none of the branches I received have
this as their top commit. I can only guess that you're looking at
something else.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
