From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Jan 2018 14:47:42 -0800
Subject: [GIT PULL] Allwinner clock changes for 4.16, round 2
In-Reply-To: <20180108034901.GA5577@wens.csie.org>
References: <20180108034901.GA5577@wens.csie.org>
Message-ID: <20180110224742.GG28313@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08, Chen-Yu Tsai wrote:
> Hi Mike, Stephen,
> 
> Here are a few more clock changes for 4.16. The DE2 clock changes have
> been around for awhile. The A83T clock fix was found by Jernej while
> working on HDMI output for the SoC. We'd like to get these in so patches
> don't pile up on the mailing lists.
> 
> ChenYu
> 
> The following changes since commit e952ca3c6b2ffdfbf9618e4bd3e9aad1ff3f5eb4:
> 
>   clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL (2017-12-08 10:08:32 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.16-2
> 
> for you to fetch changes up to 7dbc7f5f4904cfddc199af171ea095490a434f15:
> 
>   clk: sunxi-ng: a83t: Add M divider to TCON1 clock (2018-01-03 13:45:04 +0800)
> 
> ----------------------------------------------------------------
> Allwinner clock changes for 4.16, part 2
> 
> The hardware description for the DE2 clocks on the A64 and H5 SoCs is
> fixed, and support for these clocks on the H3 is added. Also, the
> description for the TCON1 clock on the A83T is fixed. All these are
> non-critical, as they have no users.

Thanks. Pulled into clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
