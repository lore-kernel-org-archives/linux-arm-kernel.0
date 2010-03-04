From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 4 Mar 2010 15:51:49 +0100
Subject: [PATCH/RFC] arm: Enable backtrace printing on oops when PC
	iscorrupted
In-Reply-To: <1267709103.6526.371.camel@e102109-lin.cambridge.arm.com>
References: <1264065809-7893-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201003040208.41421.laurent.pinchart@ideasonboard.com>
	<1267709103.6526.371.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201003041551.52294.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thursday 04 March 2010 14:25:03 Catalin Marinas wrote:
> On Thu, 2010-03-04 at 01:08 +0000, Laurent Pinchart wrote:
> > On Thursday 18 February 2010 18:07:50 Russell King - ARM Linux wrote:
> > > On Tue, Jan 26, 2010 at 05:41:01PM +0000, Catalin Marinas wrote:
> > > > On Thu, 2010-01-21 at 09:23 +0000, Laurent Pinchart wrote:
> > > > > If PC points outside kernel text, start printing the backtrace at
> > > > > LR instead.
> > > > > 
> > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > 
> > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > 
> > > Has this been queued by someone?  If not, please send it to the patch
> > > system.
> > 
> > As your mail was sent to Catalin I assumed he would take care of that. If
> > the patch should still be sent to the patch system, could you tell me
> > how to proceed ?
> 
> The patch system doesn't handle the patch authorship properly, it is
> just assigning it to the person submitting it. That's why I haven't sent
> your patch.
> 
> Have a look at http://www.arm.linux.org.uk/developer/patches/ and the
> help.
> 
> If you don't want to subscribe, I can put the patch somewhere on a Git
> tree and send Russell a pull request.

Thanks for the information. I've submitted the patch 
(http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5977/1)

-- 
Regards,

Laurent Pinchart
