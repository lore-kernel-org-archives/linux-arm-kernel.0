From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 4 May 2016 09:18:01 +0200
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
In-Reply-To: <20160429181248.GW19428@n2100.arm.linux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
Message-ID: <20160504071801.GA17045@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2016-04-29 19:12:48, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2016 at 10:32:15AM -0700, Douglas Anderson wrote:
> > This series picks patches from various different places to produce what
> > I consider the best solution to getting consistent mmc and mmcblk
> > ordering.
> > 
> > Why consistent ordering and why not just use UUIDs?  IMHO consistent
> > ordering solves a few different problems:
> 
> NAK.  Really.  Use UUIDs, that's the proper solution here.

Except that UUIDs do not solve the problem.

You have just booted of nfsroot, and you want to format u-SD card in
the external slot. How do you do that?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
