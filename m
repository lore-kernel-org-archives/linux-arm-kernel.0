From: horms@verge.net.au (Simon Horman)
Date: Fri, 27 May 2016 09:47:07 +0900
Subject: [PATCH] rm64: dts: r8a7795: Drop 0x from unit address of gic
In-Reply-To: <CAMuHMdVUSmRtFHFA1E9_sqFUEo9KER2CSW4qtjcsY0LWs6tfeA@mail.gmail.com>
References: <1464138700-12219-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVUSmRtFHFA1E9_sqFUEo9KER2CSW4qtjcsY0LWs6tfeA@mail.gmail.com>
Message-ID: <20160527004706.GF14269@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 09:02:17AM +0200, Geert Uytterhoeven wrote:
> On Wed, May 25, 2016 at 3:11 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Drop 0x from unit address of gic as this is the desired form for
> > a unit address.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> If you increase the entropy of the universe even more by adding the missing
> "a" prefix to the one-line summary, you can add my
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

deal.
