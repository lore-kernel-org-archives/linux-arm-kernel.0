From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Mar 2015 17:41:50 +0200
Subject: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
In-Reply-To: <20150304152505.GE17250@arm.com>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
 <1946782.v9knT4VCx7@avalon> <20150304152505.GE17250@arm.com>
Message-ID: <2044417.cBqDBgtKhe@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

(CC'ing Thierry Reding who was missing. Thierry, you'll have to look at the 
archive for the discussion, but here's at least a start pointer)

On Wednesday 04 March 2015 15:25:05 Will Deacon wrote:
> On Tue, Mar 03, 2015 at 11:54:46PM +0000, Laurent Pinchart wrote:
> > Hello,
> 
> Hi Laurent,
> 
> > I haven't seen any reply to this e-mail. I know that the combination of
> > IOMMU, DMA mapping and DT doesn't exactly sound like fun, but I think we
> > still need to move on :-)
> 
> Yup, and thanks for taking the time to write this up!
> 
> > Will and Arnd, could you please confirm that my summary below matches your
> > memories of our discussion ?
> 
> It certainly matches my recollection, but I suspect the devil is in the
> details and we'll have to have some discussions once somebody has a crack at
> implementing this.

You're not volunteering, are you ? ;-)

-- 
Regards,

Laurent Pinchart
