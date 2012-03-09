From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Mar 2012 18:57:04 -0700 (MST)
Subject: [GIT PULL] ARM: OMAP2+: hwmod data: cleanup in preparation for
 link array removal
In-Reply-To: <20120309014016.GC12083@atomide.com>
References: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com>
 <20120309014016.GC12083@atomide.com>
Message-ID: <alpine.DEB.2.00.1203081851570.9551@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 8 Mar 2012, Tony Lindgren wrote:

> Got these now merged into l-o master, but ran into a merge
> conflict with already queued sr branch. Resolved it by using
> your version except left out vdd_name.

Definitely we want the vdd_name fields.  Other than that it looks okay.  

> As the namings have changed for smartreflex, now I suspect it's broken 
> for the interrupts..

Hmm, not sure I understand that part?  AFAIK the SmartReflex code doesn't 
rely on hwmod names.  Or are you talking about the vdd_name?


- Paul
