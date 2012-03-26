From: alexg@meprolight.com (Alex Gershgorin)
Date: Mon, 26 Mar 2012 19:30:05 +0200
Subject: [PATCH] regmap: Add 24 bits support
In-Reply-To: <20120326145054.GV3098@opensource.wolfsonmicro.com>
References: <1332772808-13346-1-git-send-email-alexg@meprolight.com>,
 <20120326145054.GV3098@opensource.wolfsonmicro.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD1C@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
>Subject: Re: [PATCH] regmap: Add 24 bits support

On Mon, Mar 26, 2012 at 04:40:08PM +0200, Alex Gershgorin wrote:
> This patch adds support for PMIC who use regmap and 24 bit registers
> For example MC13892, the patch was tested on i.MX35-PDK

> >A similar patch from Marc Reilly has already been applied.  You don't
> >have his signoff here but then...

Sorry Marc, I missed the patch 

> +typedef struct { __u8 b[3]; } __be24;

> > ...you're adding stuff like this to the regmap headers which *clearly*
> > isn't regmap specific so this looks like a separate development.

You right,

I think it makes no sense to fix it,
why do we need two similar patches

Thanks  
