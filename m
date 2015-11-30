From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 12:55:37 -0800
Subject: [PATCH 1/3] ARM: imx: clk-vf610: fix SAI clock tree
In-Reply-To: <20151123014613.GB13744@tiger>
References: <1445141122-14183-1-git-send-email-stefan@agner.ch>
 <20151123014613.GB13744@tiger>
Message-ID: <20151130205537.GP11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, Shawn Guo wrote:
> On Sat, Oct 17, 2015 at 09:05:20PM -0700, Stefan Agner wrote:
> > 
> > Since Patch 3 also uses the fixed clock layout, it should be
> > applied after the clock tree fix too...
> > 
> > Not sure through which tree these changes should go?
> 
> Mike, Stephen,
> 
> Can I have your ACK on patch #1 so that I can send it together with 
> #2 for v4.4-rc inclusion?
> 

Yes that's fine.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
