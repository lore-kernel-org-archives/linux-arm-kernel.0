From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Oct 2013 14:31:44 +0900
Subject: [PATCH 0/3] ARM: shmobile: Lager reference serial port support
In-Reply-To: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131031053144.GP1603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 04:23:10PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> This patch set implements serial port support for the Lager reference board,
> and adds early debugging support for the r8a7790 SoC.
> 
> The code is available in my git tree at
> 
>         git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/serial-lager
> 
> The branch is based on a merge of renesas-devel-20131016, v3.12-rc7 and
> multiarch drivers, clk-prepare, r8a7790 CCF and sh-sci OF patches I've posted
> earlier today.
> 
> Laurent Pinchart (3):
>   ARM: shmobile: r8a7790: Add early debugging support

The patch above could be applied now, right?
If so, Magnus, could you review it?

>   ARM: shmobile: r8a7790: Add serial ports to the device tree
>   ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT

I would like to ask you to repost these patches once their
pre-requisites have been merged.
