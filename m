From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 10 Oct 2012 15:58:40 +0100
Subject: [GIT PULL 0/9] ARM architecture fixes for 3.7
In-Reply-To: <201210091840.25176.arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <20121009160814.GH4625@n2100.arm.linux.org.uk>
 <201210091840.25176.arnd@arndb.de>
Message-ID: <alpine.DEB.2.02.1210101557540.2689@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Oct 2012, Arnd Bergmann wrote:
> On Tuesday 09 October 2012, Russell King - ARM Linux wrote:
> > 
> > On Tue, Oct 09, 2012 at 05:22:54PM +0200, Arnd Bergmann wrote:
> > > Here are some patches that belong into your domain, I hope you can
> > > just send the lot to Linus the next time you send other patches.
> > > 
> > > These bug fixes all address problems found with automated build testing.
> > > Some of them have been around for a long time, other bugs are
> > > regressions since the merge window.
> > 
> > Apart from the sliced off comment in one commit (which XEN people need
> > to confirm they're happy with the final version), I think these are
> > otherwise fine... I'll hold off pulling them until that can be fixed.
> 
> Fixed that now, and I also added the Acks that I got in the meantime,
> changed the dependency from Xen on (CPU_v7 && !CPU_V6), and edited the
> description for patch 6 as Dave suggested.

Thanks for the update, the new Xen patch is fine by me
