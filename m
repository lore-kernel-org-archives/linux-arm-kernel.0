From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Sep 2017 10:21:26 +0100
Subject: [PATCH] arm64: Convert pr_warning to standard pr_warn
In-Reply-To: <1504636703.28899.9.camel@perches.com>
References: <1504578518-77544-1-git-send-email-cj.chengjian@huawei.com>
 <20170905091051.GA4401@leverpostej>
 <1504636703.28899.9.camel@perches.com>
Message-ID: <20170906092125.GA23268@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 11:38:23AM -0700, Joe Perches wrote:
> On Tue, 2017-09-05 at 10:10 +0100, Mark Rutland wrote:
> > On Tue, Sep 05, 2017 at 10:28:38AM +0800, chengjian c00427203 wrote:
> > > Convert pr_warning to standard pr_warn in arch/arm64/kernel/smp.c
> > > 
> > > Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> > > ---
> > >  arch/arm64/kernel/smp.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Is this a step towards removing pr_warning entirely?
> > 
> > If so, can you please fix up all occurences in arm64? i.e.
> 
> https://patchwork.kernel.org/patch/9578907/
> 

Ah, I thought I'd seen this before. :)

Catalin, Will, are you happy with Joe's patch?

Thanks,
Mark.
