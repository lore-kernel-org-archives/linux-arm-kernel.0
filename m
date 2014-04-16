From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 16:52:33 +0900
Subject: Renesas clock clk-mstp updates for clock-indices
In-Reply-To: <CAMuHMdXRbaO0obMRvRXTOQGUDOgnMzGATWHiVbQN0Huhn5bMiQ@mail.gmail.com>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAMuHMdVVc-9n4mQSj6qVyP5k9xzSstSw==nfYcFSOXtb895QUw@mail.gmail.com>
 <20140415235851.GA9817@verge.net.au>
 <CAMuHMdXRbaO0obMRvRXTOQGUDOgnMzGATWHiVbQN0Huhn5bMiQ@mail.gmail.com>
Message-ID: <20140416075232.GC12344@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 09:12:15AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Apr 16, 2014 at 1:58 AM, Simon Horman <horms@verge.net.au> wrote:
> >> As we now have "renesas,clock-indices" in v3.14, the question about backwards
> >> compatibility became moot.
> >>
> >> Can you please combine your two patches
> >>
> >> [PATCH 1/2] clk: shmobile: clk-mstp: change to using clock-indices
> >> [PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for indices field
> >>
> >> into a single patch, and submit to Mike?
> >>
> >> Once it's in Mike's clk-next, we can do the following to get everything in
> >> v3.15:
> >>   1. Simon cherry-picks Mike's commit into his fixes-for-v3.15 branch,
> >>   2. we fix arch/arm/boot/dts/r8a7790.dtsi and .../r8a7791.dtsi there,
> >>   3. fixes-for-v3.15 gets into mainline through arm-soc.
> >>
> >> Does that sound like plan?
> >
> > I think a better approach would be for me to use a branch of Mike's
> > or an rc release as a basis for steps 2. and 3. Once such a branch
> > or rc release is available.
> 
> That would also work.
> 
> The reasons I proposed cherry-picking were:
>   1. A branch may be overkill for just one small commit, putting some
>     burden on Mike,
>   2. An rc release assumes Mike plans to send another pull request soon.
> 
> Anyway, the goal is to get this fixed in v3.15, whatever approach ;-)

Yes, that much we can all agree on :)
