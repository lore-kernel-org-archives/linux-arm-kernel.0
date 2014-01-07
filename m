From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 08 Jan 2014 00:06:39 +0100
Subject: [PATCH 0/2] clk: shmobile rcar-gen2 fixes
In-Reply-To: <CAMuHMdUVGAL_h8iezPHZsmfC+77xXE9+irNywk4LYcqAMk9JGg@mail.gmail.com>
References: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdUVGAL_h8iezPHZsmfC+77xXE9+irNywk4LYcqAMk9JGg@mail.gmail.com>
Message-ID: <1591253.8BzYfubhGS@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tuesday 07 January 2014 17:59:01 Geert Uytterhoeven wrote:
> On Tue, Jan 7, 2014 at 5:47 PM, Laurent Pinchart wrote:
> > Geert, could you please verify that the series fixes your QSPI clock
> > issues with the Koelsch board ?
> > 
> > Laurent Pinchart (2):
> >   clk: shmobile: rcar-gen2: Fix clock parent all non-PLL clocks
> >   clk: shmobile: rcar-gen2: Fix qspi divisor
> 
> Thanks, both:
> 
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you.

Mike, could you please pick those patches up for v3.14 ?

-- 
Regards,

Laurent Pinchart
