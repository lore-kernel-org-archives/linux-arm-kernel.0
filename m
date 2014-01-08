From: horms@verge.net.au (Simon Horman)
Date: Wed, 8 Jan 2014 09:25:40 +0900
Subject: [PATCH 0/2] clk: shmobile rcar-gen2 fixes
In-Reply-To: <CAMuHMdUVGAL_h8iezPHZsmfC+77xXE9+irNywk4LYcqAMk9JGg@mail.gmail.com>
References: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdUVGAL_h8iezPHZsmfC+77xXE9+irNywk4LYcqAMk9JGg@mail.gmail.com>
Message-ID: <20140108002540.GE5136@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 05:59:01PM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 7, 2014 at 5:47 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > Geert, could you please verify that the series fixes your QSPI clock issues
> > with the Koelsch board ?
> >
> > Laurent Pinchart (2):
> >   clk: shmobile: rcar-gen2: Fix clock parent all non-PLL clocks
> >   clk: shmobile: rcar-gen2: Fix qspi divisor
> 
> Thanks, both:
> 
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
