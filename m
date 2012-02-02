From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Feb 2012 20:21:13 +0000
Subject: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
 suspend is not implemented
In-Reply-To: <201202021940.26552.rjw@sisk.pl>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
 <201201302358.26152.rjw@sisk.pl>
 <1328183022.28171.165.camel@sauron.fi.intel.com>
 <201202021940.26552.rjw@sisk.pl>
Message-ID: <20120202202113.GA17309@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 07:40:26PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 02, 2012, Artem Bityutskiy wrote:
> > On Mon, 2012-01-30 at 23:58 +0100, Rafael J. Wysocki wrote:
> > > Thanks, but is anyone actually going to push it to Linus any time soon?
> > 
> > I agree, but I am not the maintainer so cannot answer. David Woodhouse
> > is aware of this, but I do not know when he gonna send the pull request.
> 
> Well, the problem is being reported by more and more people, so I'd
> like to push the fix quickly.
> 
> David, please let me know if you don't want me to include the $subject patch
> into the next PM fixes pull request.  If I don't hear from you, I'll push it
> next week for -rc4.

I too have it in my tree as a patch which Artem sent me, as it's rather
fundamental to not oopsing the kernel when you suspend/resume on any ARM
platform.
