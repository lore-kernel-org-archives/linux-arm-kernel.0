From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 22 Mar 2013 11:32:34 +0200
Subject: [RFC 0/8]: omap4: clk: move clock data under drivers/clk
In-Reply-To: <514BEC05.3050105@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
 <514BEC05.3050105@ti.com>
Message-ID: <1363944754.15426.186.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-22 at 10:58 +0530, Rajendra Nayak wrote:
> Tero,
> 
> On Thursday 21 March 2013 11:05 PM, Tero Kristo wrote:
> > Hi,
> > 
> > This is an RFC version of the clock data move under drivers/clk.
> > Tested under 3.8 and boots fine, but don't try this out unless
> > you are experimental sort (I quickly tried with 3.9-rc3 and it failed to
> > boot with that.)
> > 
> > The approach taken here has minimal impact on the clock data
> > and should make it easy to transfer clock data for omap2 / omap3 and
> > omap5 also. omap4 was only done as a proof of concept.
> > 
> > Any comments appreciated.
> 
> I strangely only see the cover letter delivered to me and no
> patches. Do you have a branch with the patches which you can
> share?

Keerthy had a similar question. It looks like TI people have had
problems with mailing list subscriptions as of late, and I am actually
also getting moderator bounces for my emails from linux-arm-kernel list
atm.

Anyway, I just pushed a branch here:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: linux-3.8-omap4-clk-move

-Tero
