From: joe@perches.com (Joe Perches)
Date: Wed, 16 Sep 2009 13:13:58 -0700
Subject: [PATCH] MAINTAINERS: Move ARM lists to infradead
In-Reply-To: <m3d45qpsgl.fsf@intrepid.localdomain>
References: <1253117388.2567.17.camel@Joe-Laptop.home>
	<20090916181018.GA19728@Chamillionaire.breakpoint.cc>
	<1253125008.2567.32.camel@Joe-Laptop.home>
	<m3d45qpsgl.fsf@intrepid.localdomain>
Message-ID: <1253132038.10465.5.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-16 at 22:03 +0200, Krzysztof Halasa wrote:
> Joe Perches <joe@perches.com> writes:
> > I believe it's still moderated.
> Does that matter to the point we have to put it in the file?
> Non-spam from non-subscribers passes through, right? The "moderated for
> non-subscribers" suggests that one should subscribe prior to posting,
> which is IMHO not the case.

I don't much care which is selected, but I think it's clear
moderated doesn't mean subscribers-only.

"moderated for non-subscribers" means there might be a
rejection or a delay before a message is forwarded to a list.

Here are the lists that are marked "moderated" in MAINTAINERS

$ grep moderated MAINTAINERS | sort | uniq
L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
L:	bluesmoke-devel at lists.sourceforge.net (moderated for non-subscribers)
L:	linux-am33-list at redhat.com (moderated for non-subscribers)
L:	linux-fbdev-devel at lists.sourceforge.net (moderated for non-subscribers)
L:	linux-geode at lists.infradead.org (moderated for non-subscribers)
L:	linux-zigbee-devel at lists.sourceforge.net (moderated for non-subscribers)
L:	ocfs2-devel at oss.oracle.com (moderated for non-subscribers)
L:	rds-devel at oss.oracle.com (moderated for non-subscribers)
L:	tpmdd-devel at lists.sourceforge.net (moderated for non-subscribers)
