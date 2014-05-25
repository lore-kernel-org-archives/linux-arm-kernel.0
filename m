From: will.deacon@arm.com (Will Deacon)
Date: Sun, 25 May 2014 11:43:59 +0100
Subject: [PATCH v7 0/4] Support for Generic PCI Host Controller
In-Reply-To: <201405232119.23891.arnd@arndb.de>
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
 <201405232119.23891.arnd@arndb.de>
Message-ID: <20140525104359.GA2343@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, May 23, 2014 at 08:19:23PM +0100, Arnd Bergmann wrote:
> On Friday 23 May 2014, Will Deacon wrote:
> >   - Removed redundant MIGHT_HAVE_PCI selections from multiplatform-enabled
> >     SoCs
> > 
> >   - Included patch from Srikanth for generic Configuration Space access to
> >     be factored out and used by other drivers
> > 
> >   - Fixed minor issue in I/O port allocation (I had a >= instead of a >)
> > 
> 
> It seems strange that you include the patch from Srikanth but then use
> a separate copy of the same code in patch 2. Is that intentional?

That was a combination of me not being sure about the status of Srikanth's
patch (the review didn't seem to conclude) but also then forgetting to move
over to using it.

However, judging by your most recent comments, I'm glad I didn't spend any
time on it!

Will
