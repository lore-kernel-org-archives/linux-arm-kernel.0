From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Mar 2012 19:04:31 -0700 (MST)
Subject: [GIT PULL] ARM: OMAP2+: hwmod data: cleanup in preparation for
 link array removal
In-Reply-To: <alpine.DEB.2.00.1203081851570.9551@utopia.booyaka.com>
References: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
 <20120309014016.GC12083@atomide.com>
 <alpine.DEB.2.00.1203081851570.9551@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1203081900500.26543@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

on second thought...

On Thu, 8 Mar 2012, Paul Walmsley wrote:

> On Thu, 8 Mar 2012, Tony Lindgren wrote:
> 
> > Got these now merged into l-o master, but ran into a merge
> > conflict with already queued sr branch. Resolved it by using
> > your version except left out vdd_name.
> 
> Definitely we want the vdd_name fields.  Other than that it looks okay.  

I guess that other SR series that you merged removed the vdd_name fields?

If so then yeah, we'd better leave those out.

This means that I'm going to have to rebase those big hwmod data changes 
:-(

Can you send me a stable commit for that?


- Paul
