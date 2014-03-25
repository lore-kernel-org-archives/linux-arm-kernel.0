From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 25 Mar 2014 14:20:14 +0000
Subject: [PATCH 1/3] ARM: kprobes: Prevent known test failures stopping
 other tests running
In-Reply-To: <53318DD8.5010004@linaro.org>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-2-git-send-email-tixy@linaro.org>
 <53304CB3.6040409@linaro.org> <1395679745.3465.41.camel@linaro1.home>
 <20140324165601.GR7528@n2100.arm.linux.org.uk>
 <53307A99.1070207@linaro.org>
 <20140325140254.GT7528@n2100.arm.linux.org.uk>
 <53318DD8.5010004@linaro.org>
Message-ID: <1395757214.3478.69.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-25 at 10:08 -0400, David Long wrote:
> On 03/25/14 10:02, Russell King - ARM Linux wrote:
> > On Mon, Mar 24, 2014 at 02:34:01PM -0400, David Long wrote:
> >> On 03/24/14 12:56, Russell King - ARM Linux wrote:
> >>> On Mon, Mar 24, 2014 at 04:49:05PM +0000, Jon Medhurst (Tixy) wrote:
> >>>> Yes, I now see this in Russell's patch tracker (with a less verbose
> >>>> commit message) as patch 7978, and it's marked as "Applied to git-curr
> >>>> (uprobes branch)". Perhaps it got dropped along with the rest of the
> >>>> uprobes branch when the config problems were discovered, Russell?
> >>>
> >>> If it was applied to the uprobes branch, and it wasn't part of David's
> >>> uprobes git pull request, then yes, it doesn't exist anymore.
> >>>
> >>
> >> OK.  Just to be absolutely clear:  this doesn't create any new problem,
> >> but we do then need it in Tixy's new patchset in order to fix this older
> >> bug.
> >
> > Okay, so I'll just wait for Tixy's patch set then?
> >
> 
> You don't have to delay anything, just eventually (e.g.: v3.16) take 
> Tixy's patch as  a separate patch fixing this old bug.  The uprobes 
> stuff is fine just as it is.  There are no interdependencies.

In case you are talking at crossed purposes. The uprobes code which
Russell has already pulled into his tree, and is in linux-next, is fine,
nothing need changing, and is safe to go into 3.15.

The 3 patches I posted, which this is in reply to, are for fixes for
minor bugs in kprobes which have been there for 3 years, and can wait
for 3.16.

-- 
Tixy
