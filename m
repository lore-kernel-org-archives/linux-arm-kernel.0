From: tony@atomide.com (Tony Lindgren)
Date: Sun, 19 Aug 2012 23:57:41 -0700
Subject: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
In-Reply-To: <CAPo=G1w5N5GVra7TK=En9xnaFmNNP1Zb7g2tZSjg8CO8wewOwA@mail.gmail.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
 <20120817130723.GZ11011@atomide.com> <502E43BC.30708@bitmer.com>
 <502E4F2B.6060403@ti.com> <20120818060810.GH11011@atomide.com>
 <CAPo=G1w5N5GVra7TK=En9xnaFmNNP1Zb7g2tZSjg8CO8wewOwA@mail.gmail.com>
Message-ID: <20120820065740.GK11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ujfalusi, Peter <peter.ujfalusi@ti.com> [120818 08:58]:
> Hi Tony,
> 
> On Sat, Aug 18, 2012 at 8:08 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Thanks, is this patch still correct so it does not try to enable FIFO
> > for 2420?
> 
> Yes it only enables the FIFO for 2430, 2420 is not affected.

OK thanks for the clarification.

Tony
