From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Mar 2015 03:35:15 +0100
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <871tkbxwup.fsf@free.fr>
References: <20150216130549.GF14545@x1> <20150325140725.GA11499@kroah.com>
 <871tkbxwup.fsf@free.fr>
Message-ID: <201503280335.16280.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 March 2015, Robert Jarzmik wrote:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Feb 20, 2015 at 05:02:57PM +0100, Robert Jarzmik wrote:
> >> If there is no solution, I'll fallback through arch/arm/plat-pxa, not very nice,
> >> but it has to land somewhere, I don't want lubbock to remain broken.
> >
> > drivers/platform/arm ?
> Most certainly.
> 
> I'll submit that to drivers/platform/arm/pxa, and maintain that pxa tree. As for
> drivers/platform/arm, do you want also maintainers to step up, or will you take
> the review/merge burden ?
> 

I'd much prefer not to add drivers/platform/arm, which would make it too easy
to add random stuff there. What is the problem with leaving it in mach-pxa?

	Arnd
