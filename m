From: yibin.gong@nxp.com (Robin Gong)
Date: Thu, 24 May 2018 01:42:46 +0000
Subject: [PATCH v1] dma: imx-sdma: add virt-dma support
In-Reply-To: <20180523133441.GK20991@vkoul-mobl>
References: <1521735499-29138-1-git-send-email-yibin.gong@nxp.com>
 <20180522100948.6xsq3unhyyyd7zz3@pengutronix.de>
 <1527099973.3990.37.camel@nxp.com>
 <20180523105612.u4wbezh7fzkv4wfh@pengutronix.de>
 <20180523133441.GK20991@vkoul-mobl>
Message-ID: <1527154959.3990.39.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, I'll try to split it.
On ?, 2018-05-23 at 19:04 +0530, Vinod wrote:
> On 23-05-18, 12:56, s.hauer at pengutronix.de wrote:
> 
> > 
> > Well, it's somewhat related to virtual dma support, but that's not
> > my
> > point. My point is that this patch is quite big and thus hard to
> > review.
> > If we find ways to make it smaller and to split it up in multiple
> > patches then we should do so, because it makes it easier to review
> > and
> > in case you break something here we raise the chance that a "git
> > bisect"
> > lands on a smaller patch which is easier to understand.
> > 
> > Please try and make that a separate change. I haven't really looked
> > into
> > it and it may not be possible due to reasons I haven't seen, but
> > please
> > at least give it a try.
> That is something would help me as well. I have reviewed the patch
> and am not
> sure I fully understand the changes, so breaking up stuff would
> definitely help
> in the review..
> 
