From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Nov 2013 15:52:02 -0800
Subject: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
In-Reply-To: <87ioveeo0x.fsf@octavius.laptop.org>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
 <20131118184723.GR10317@atomide.com>
 <87ioveeo0x.fsf@octavius.laptop.org>
Message-ID: <20131126235201.GV26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Chris Ball <cjb@laptop.org> [131126 15:35]:
> Hi Tony,
> 
> On Mon, Nov 18 2013, Tony Lindgren wrote:
> > We are wrongly relying on device id for the DMA configuration
> > which can lead to wrong DMA channel being selected.
> >
> > Fix the issue by using the standard resources like we should.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc at vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Feel free to merge via your tree:
> 
> Acked-by: Chris Ball <cjb@laptop.org>

OK thanks will merge both mmc fixes.

Tony
