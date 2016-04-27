From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Apr 2016 08:57:05 +1000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC
 Updates for v4.7
In-Reply-To: <4754122.zMqi1lHELM@wuerfel>
References: <cover.1461632180.git.horms+renesas@verge.net.au>
 <4754122.zMqi1lHELM@wuerfel>
Message-ID: <20160427225705.GB29115@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 12:44:48PM +0200, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 11:28:38 Simon Horman wrote:
> > This pull request is based on a merge of:
> > 
> > * Thee previous round of such requests, tagged as renesas-rcar-sysc-for-v4.7,
> >   which you have previously pulled.
> > * The clk-renesas-for-v4.7-tag2 tag of Geert Uytterhoeven's renesas-drivers
> >   tree which has been accepted into clk-next by Stephen Boyd.
> 
> I've pulled it into next/drivers now.
> 
> > There are follow-up DT changes that depend on this driver which I plan to
> > send in a pull-request for in the near future.
> 
> Ok, I need to revisit your earlier explanation of the exact dependencies
> here and see if we can find a way to merge this nicely. We usually
> have the next/dt branch before the next/drivers branch, so this reverse
> dependency would require a next/dt2 branch unless we can either change
> the order for the 4.7 merge window for all platforms, or find a way
> to merge (most of) the following DT changes without having the driver
> done first.

I have sent the relevant pull-requests for you to review.
I have tried to keep the patches contained in pull-requests
with awkward dependencies to a minimum.
