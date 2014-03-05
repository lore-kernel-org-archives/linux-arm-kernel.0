From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Mar 2014 08:28:37 -0800
Subject: [PATCHv2 14/14] ARM: OMAP3: clock: remove legacy clock data
In-Reply-To: <5316D318.8080405@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-15-git-send-email-t-kristo@ti.com>
 <20140304173242.GB17470@atomide.com> <5316D318.8080405@ti.com>
Message-ID: <20140305162837.GB4983@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140304 23:35]:
> On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140304 01:22]:
> >>This is no longer needed as clock data is provided through DT.
> >
> >And this one we cannot apply yet until omap3 is booting in device tree
> >only mode.
> 
> What is missing to achieve this? Some boards are not booting in DT
> mode yet or?

It seems that the last missing pieces are the DSS bindings and
.dts file for the pandora. At least I can't think of anything
else that's missing or could not be done using pdata-quirks.c.

Regards,

Tony
