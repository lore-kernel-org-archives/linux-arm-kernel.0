From: horms@verge.net.au (Simon Horman)
Date: Wed, 8 Apr 2015 09:44:05 +0900
Subject: [PATCH 1/6] Revert "staging: board: disable as it breaks the
 build"
In-Reply-To: <CAMuHMdX1uHq23h_qsq2csTSYbAhN9ZDdMviDi=KtbLuWucYWXA@mail.gmail.com>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-2-git-send-email-geert+renesas@glider.be>
 <20150406004031.GD1841@verge.net.au>
 <CAMuHMdX1uHq23h_qsq2csTSYbAhN9ZDdMviDi=KtbLuWucYWXA@mail.gmail.com>
Message-ID: <20150408004400.GA3456@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 03:16:54PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 6, 2015 at 2:40 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Apr 03, 2015 at 02:41:58PM +0200, Geert Uytterhoeven wrote:
> >> This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.
> >>
> >> Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
> >> fixed the build of drivers/staging/board/board.c.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by? Reviewed-by? Tested-by? Rejected-by?

To be honest I was flipping between Signed-off-by and Acked-by.
But it seems you don't think either of those would be appropriate.
So how about:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
