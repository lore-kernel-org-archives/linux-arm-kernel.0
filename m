From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Mar 2016 16:39:23 -0700
Subject: [GIT PULL] bcm2835 clk changes for 4.6 maybe
In-Reply-To: <1458265130-30734-1-git-send-email-eric@anholt.net>
References: <1458265130-30734-1-git-send-email-eric@anholt.net>
Message-ID: <20160329233923.GR18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17, Eric Anholt wrote:
> This is late, so feel free to drop it, but I figured I'd send it to
> you in case you were still open to merges.  I've pounded on it a bit
> today (modesets to all sorts of resolutions on HDMI, used it for
> testing the DPI panel support that I'm hoping to have for 4.7, and did
> a whole lot of browsing of clk_summary as I debugged DPI), and kbuild
> test robot came back clean, so I'm pretty happy with it.
> 
> The following changes since commit 4d3ac6662452060721599a3392bc2f524af984cb:
> 
>   clk: bcm2835: fix check of error code returned by devm_ioremap_resource() (2016-03-15 18:14:11 -0700)
> 
> are available in the git repository at:
> 
>   git at github.com:anholt/linux.git tags/bcm2835-clk-next-2016-03-17

Please make sure to use a proper URL here. I don't have access to
git at github.com, but I can fetch this from
git://github.com/anholt/linux.git. The tag and the contents match
so I'm fairly confident all is well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
