From: scottwood@freescale.com (Scott Wood)
Date: Wed, 9 Sep 2015 11:39:57 -0500
Subject: [PATCH v2 06/10] clk: qoriq: Add ls2080a support.
In-Reply-To: <1441349872-4560-7-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-7-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1441816797.29081.9.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-04 at 12:27 +0530, Bhupesh Sharma wrote:
> From: Scott Wood <scottwood@freescale.com>
> 
> LS2080A is the first implementation of the chassis 3 clockgen, which
> has a different register layout than previous chips.  It is also little
> endian, unlike previous chips.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

You should add your own signoff when passing on someone else's patch.

FWIW, I'm likely to squash this with my previous clk-qoriq patches when I 
resubmit.

-Scott
