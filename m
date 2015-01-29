From: horms@verge.net.au (Simon Horman)
Date: Thu, 29 Jan 2015 17:53:30 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: Correct SDHI clock labels and
 output-names
In-Reply-To: <CAMuHMdXktWqe_+HhORN0iWEMLm=y2fS52PFtPK4RzAHQMHLYXw@mail.gmail.com>
References: <1422496038-3915-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXktWqe_+HhORN0iWEMLm=y2fS52PFtPK4RzAHQMHLYXw@mail.gmail.com>
Message-ID: <20150129085330.GB21851@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 09:05:15AM +0100, Geert Uytterhoeven wrote:
> On Thu, Jan 29, 2015 at 2:47 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > There appears to have been some inconsistency and confusion here as on
> > the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
> > the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.
> >
> > Fixes: 59e79895b95892863 ("ARM: shmobile: r8a7791: Add clocks")
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
