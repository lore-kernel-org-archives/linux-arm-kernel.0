From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 6 Jan 2010 23:40:21 -0700 (MST)
Subject: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
	related update.
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C041BF11@dbde02.ent.ti.com>
References: <1261583238-22187-1-git-send-email-abhijitpagare@ti.com>
	<alpine.DEB.2.00.0912300125320.24862@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C02E919C@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1001051608340.21295@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C041BB3A@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1001061401560.10034@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C041BF11@dbde02.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1001062334540.10034@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jan 2010, Pagare, Abhijit wrote:

> It shouldn't take all that long. I will internally send you the 
> auto-generated file having the dependency details soon. Do let me know 
> if you want any modification in it. If all that's done in a couple of 
> days then the patch above can be skipped.

That sounds great.  As far as I know, the only public branch that contains 
your OMAP4 patches so far is the for_2.6.34 branch on my git server.  It's 
not in mainline yet.  So let's see if we can get that fixed up with the 
sleep and wakeup dependencies.

If people are actually using code from the for_2.6.34 branch to boot their 
OMAP4 SDPs, I'd be happy to post a derivative branch with your temporary 
fixup patch added for them to use instead.  Would that be useful?

- Paul
