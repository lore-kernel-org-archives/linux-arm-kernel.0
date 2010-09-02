From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 17:08:11 +0100
Subject: [PATCH] amba_clcd: Check min clock limits based on selected mode
In-Reply-To: <1283353934-15790-1-git-send-email-wellsk40@gmail.com>
References: <1283353934-15790-1-git-send-email-wellsk40@gmail.com>
Message-ID: <20100902160811.GT26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 08:12:14AM -0700, wellsk40 at gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> Check the minimum clock limits based on whether TFT or STN mode
> is selected. Some TFT panels have nominal values under the
> minimum STN constraints.
> 
> Tested on a PL111/TFT LCD combo at hsync_len=3(HSW),
> right_margin=3(HBP), and left_margin=22(HFP).

Ok.
