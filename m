From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 26 Mar 2012 11:33:53 +0530
Subject: [PATCH v3 00/13] dmaengine: imx-dma: merge dma arch code into
 dmaengine.
In-Reply-To: <CACKLOr0JTgp+poXCNg8+8pXko3s2JWQhovMw8Z1j-q4aL4oaKQ@mail.gmail.com>
References: <1331306449-28591-1-git-send-email-javier.martin@vista-silicon.com>
 <1332344363.19804.12.camel@vkoul-udesk3>
 <CACKLOr03tTymT1vdTH7=nqEHu3OvAinPUHEusK+mR+J6Yc35mQ@mail.gmail.com>
 <CACKLOr0JTgp+poXCNg8+8pXko3s2JWQhovMw8Z1j-q4aL4oaKQ@mail.gmail.com>
Message-ID: <1332741833.19804.17.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-22 at 15:11 +0100, javier Martin wrote:
> On 22 March 2012 10:39, javier Martin <javier.martin@vista-silicon.com> wrote:
> > On 21 March 2012 16:39, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> >> This doesn't apply for me (starting with 6th) on current slave-dma.next
> >> due to obvious changes which have gone into imx.
> >>
> >> Can you quickly rebase the series and resend.
> >
> > Great,
> > now your 'next' branch is actually broken for imx-dma.
> >
> > I'm currently trying a bisect to find out what is the commit
> > responsible for that but I suspect it will be related to the cookie
> > changes submitted by Russell.
I had these in branch for quite some time for people to look and point
out any issues with merge.
> 
> Here,
> take a look at this series:
> 
> [PATCH v4 00/15] dmaengine: imx-dma: rebase of features for 3.4.
> 
> I've included a new fix patch which solves the merge issue.
Thanks Applied all, now
> 
> Regards.


-- 
~Vinod
