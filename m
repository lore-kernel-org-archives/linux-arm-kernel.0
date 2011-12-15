From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Dec 2011 10:16:46 -0800
Subject: [PATCH v7 00/14] Add support for tegra30 and cardhu
In-Reply-To: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111215181646.GA10631@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 05:03:12PM +0200, Peter De Schrijver wrote:
> This patchset adds support for the tegra30 SoC and the cardhu development
> board.
> 
> Patchset is on top of linux-next and
> http://www.spinics.net/lists/linux-tegra/msg03016.html.
> 
> Most important changes in v7:
> 
> * split board-dt.c in board-dt-tegra20.c and board-dt-tegra30.c
> * split early init preparation into several patches
> * remove tegra_sdmmc_tap_delay. Drivers should use tegra2_sdmmc_tap_delay as
>   from tegra30 onwards this feature will no longer handled by the clock code
>   as it's implemented in the SDMMC block now.
> * remove CONFIG_CARDHU and the corresponding Kconfig entry

Thanks, this is looking pretty good by now, and remaining rough edges
(if any), can be fixed up over time as well.

I'm ok with it going in but lets have it sit for another day or two until
Stephen is back and has a chance to look it through as well. Colin had
some questions that I want to make sure he's happy with the answers to
as well.


-Olof
