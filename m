From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 2 Feb 2012 21:36:51 +0100
Subject: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
 suspend is not implemented
In-Reply-To: <20120202202113.GA17309@n2100.arm.linux.org.uk>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
 <201202021940.26552.rjw@sisk.pl>
 <20120202202113.GA17309@n2100.arm.linux.org.uk>
Message-ID: <201202022136.51867.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 02, 2012, Russell King - ARM Linux wrote:
> On Thu, Feb 02, 2012 at 07:40:26PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 02, 2012, Artem Bityutskiy wrote:
> > > On Mon, 2012-01-30 at 23:58 +0100, Rafael J. Wysocki wrote:
> > > > Thanks, but is anyone actually going to push it to Linus any time soon?
> > > 
> > > I agree, but I am not the maintainer so cannot answer. David Woodhouse
> > > is aware of this, but I do not know when he gonna send the pull request.
> > 
> > Well, the problem is being reported by more and more people, so I'd
> > like to push the fix quickly.
> > 
> > David, please let me know if you don't want me to include the $subject patch
> > into the next PM fixes pull request.  If I don't hear from you, I'll push it
> > next week for -rc4.
> 
> I too have it in my tree as a patch which Artem sent me, as it's rather
> fundamental to not oopsing the kernel when you suspend/resume on any ARM
> platform.

It actually affects everyone using MTD and suspend (not only ARM) and that's
why I thought I'd take it, but I'm fine with any other resolution as long as
the patch goes to Linus before 3.3-final.

Thanks,
Rafael
