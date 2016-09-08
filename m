From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Sep 2016 12:56:53 -0700
Subject: [GIT PULL] Allwinner clock fixes for 4.8
In-Reply-To: <20160907193335.GA4283@lukather>
References: <20160907193335.GA4283@lukather>
Message-ID: <b03d92eb-ac69-506d-d05a-e28bca5ca284@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2016 12:33 PM, Maxime Ripard wrote:
> Hi Mike, Stephen,
>
> Please pull the following tag for the 4.8 release.
>
> Thanks!
> Maxime
>
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
>
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.8
>
> for you to fetch changes up to 6654674cb7b5953ac04fc9d7f5f511676ae97e29:
>
>   clk: sunxi-ng: Fix wrong reset register offsets (2016-08-29 08:38:55 +0200)
>
> ----------------------------------------------------------------
> Clock Fixes for the Allwinner SoCs, 4.8 Edition
>
> The usual bunch of fixes to the our clock drivers, mostly targetted to the
> brand new sunxi-ng drivers.

Pulled, thanks. But,

>
> ----------------------------------------------------------------
> Chen-Yu Tsai (2):
>       clk: sunxi-ng: Fix inverted test condition in ccu_helper_wait_for_lock

we already had this one in clk-fixes. Git figured it out of course.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
