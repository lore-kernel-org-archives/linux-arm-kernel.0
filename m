From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 19 Sep 2011 08:29:34 +0530
Subject: [PATCH v8 00/16] To use DMA generic APIs for Samsung DMA
In-Reply-To: <CAJe_ZhdrPMbBOkfwg=PFyVU14eT0Gc0=rtKwEiQCH5-Q5-CtVQ@mail.gmail.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
	<1315980099.26251.498.camel@vkoul-udesk3>
	<CABb+yY25NTbtRPOw-KH8U4zA1Bo8q0BDM8SXyrsobG7NEv8edg@mail.gmail.com>
	<1315999032.26251.501.camel@vkoul-udesk3>
	<CAJe_ZhdrPMbBOkfwg=PFyVU14eT0Gc0=rtKwEiQCH5-Q5-CtVQ@mail.gmail.com>
Message-ID: <1316401174.21359.3.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-09-14 at 17:03 +0530, Jassi Brar wrote:
> On 14 September 2011 16:47, Vinod Koul <vinod.koul@intel.com> wrote:
> 
> >> The changelog for [PATCH v8 04/16] is misleading - we don't need any
> >> modification for the reason mentioned in changelog. But the modification
> >> has positive side-effect of preventing callbacks during terminate_all which
> >> is no way understood from the changelog. So I would like to changelog
> >> corrected.
> > I thought change log was correct in depicting what patch does and Boojin
> > had replied.... I will check again...
> 
> I didn't reply because I ran out of ways to explain the same thing in
> different words.
I checked again the patch, change log and your comments.
I agree with current change log, and also your observation is right but
that is just a side effect, which IMO should be best left to developer
to choose or not, in this case she ignored it

So no changes to this and I a ready to merge it to my next in a day or
two...

-- 
~Vinod
