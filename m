From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 09:56:25 -0700
Subject: [PATCH 0/2] iProc clock driver fixes
In-Reply-To: <5591B97D.2080003@broadcom.com>
References: <1435613410-18698-1-git-send-email-rjui@broadcom.com>
 <5591B97D.2080003@broadcom.com>
Message-ID: <20150702165625.GD7201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29, Ray Jui wrote:
> To Michael's new email.
> 
> On 6/29/2015 2:30 PM, Ray Jui wrote:
> > This patch series fixes two issues in the Broadcom iProc clock driver,
> > reported by Dan Carpenter <dan.carpenter@oracle.com>: 1) a memory leak from
> > the clock names; 2) 32-bit/64-bit arithmetic
> > 
> > Code base used is the latest linux-next (20150629) and its GITHUB link is:
> > https://github.com/Broadcom/cygnus-linux/tree/iproc-clk-misc-fix-v1
> > 
> > Ray Jui (2):
> >   clk: iproc: fix memory leak from clock name
> >   clk: iproc: fix bit manipulation arithmetic
> > 

Applied both to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
