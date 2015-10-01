From: lee@kernel.org (Lee Jones)
Date: Thu, 1 Oct 2015 15:43:09 +0100
Subject: [PATCH 1/4] clk: bcm2835: Move under bcm/ with other Broadcom
 SoC clk drivers.
In-Reply-To: <20150908192257.GQ15099@codeaurora.org>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
 <1441562263-19888-2-git-send-email-eric@anholt.net>
 <20150907064838.GE4796@x1> <20150908192257.GQ15099@codeaurora.org>
Message-ID: <20151001144309.GZ3214@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Sep 2015, Stephen Boyd wrote:

> On 09/07, Lee Jones wrote:
> > On Sun, 06 Sep 2015, Eric Anholt wrote:
> > 
> > > clk-bcm2835.c predates the drivers under bcm/, but all the new BCM
> > > drivers are going in there so let's follow them.
> > > 
> > > Signed-off-by: Eric Anholt <eric@anholt.net>
> > > ---
> > >  drivers/clk/Makefile          |  1 -
> > >  drivers/clk/bcm/Makefile      |  1 +
> > >  drivers/clk/bcm/clk-bcm2835.c | 60 +++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/clk/clk-bcm2835.c     | 60 -------------------------------------------
> > 
> > You need to resubmit this with `git format-patch -M`.
> 
> You don't have to. It would have been nice if it was formatted
> with -M so that review is easier, but we can always apply the
> patch and then check the result to make sure things look the
> same.

I vehemently avoid having to apply patches to my local repo in order
to review them.  Submitters should always be encouraged to use -M,
especially in cases where there have been changes.
