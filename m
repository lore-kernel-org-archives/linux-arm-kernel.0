From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 29 Oct 2012 05:19:54 +0000 (UTC)
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <50806B18.1010502@ti.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <50806B18.1010502@ti.com>
Message-ID: <alpine.DEB.2.00.1210290518120.30274@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav

On Fri, 19 Oct 2012, Vaibhav Hiremath wrote:

> Couple of reasons,
> 
> 1. These flags were added for validation, so I expect cpsw driver
> should work without these flags set. I tested it mounting NFS as rootFS
> and it works for me.
> 
> 2. There is HW bug as far as idle (in turn ocp reset) is concerned, and
> needs special handling for this. I already have patch for this, which I
> will submit it to the list.
> 
> http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;h=a28da2ac98f173f97dbbb46be1ce0a3879f21a11
> 
> 
> Note: Sorry for long commit description, it was screwed up by someone
> while git push.
> 
> 
> I have pushed the tested branch to (linux-omap/master + CPSW patches) -
> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging

Just checking on this one.  I don't mean to rush you, but if you have 
some patches you'd like to see integrated for 3.8 here, it would be good 
to get them posted before the end of the week.


- Paul
