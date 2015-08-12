From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Aug 2015 17:48:22 +0900
Subject: [GIT PULL] Renesas ARM Based SoC CPG MSTP Clock Domain Updates
 for v4.3
In-Reply-To: <20150811133843.GP30181@localhost>
References: <cover.1438911559.git.horms+renesas@verge.net.au>
 <20150811133843.GP30181@localhost>
Message-ID: <20150812084822.GB16058@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 03:38:43PM +0200, Olof Johansson wrote:
> On Fri, Aug 07, 2015 at 11:12:03AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC CPG MSTP clock domain updates
> > for v4.3.
> > 
> > This pull request is based on "Third Round of Renesas ARM Based SoC DT
> > Updates for v4.3", tagged as renesas-dt3-for-v4.3, which I have also sent a
> > pull-request for.
> > 
> > The reason for that base is that the DT changes in this series update nodes
> > added in that tag.
> > 
> > This series begins with driver changes and follows up with DT changes.
> > The latter depend on the former.
> 
> I see the acked-by tags on the clk patches, but it took some searching to find
> the ack email from Stephen.
> 
> Can you please make our homework a bit easier when providing that in
> the future?

Sure, I hadn't realised that you liked to track down Acks to that extent.

As practice for myself I've included some notes in the repost of the
patches in question.  Please let me know if you need something different.
