From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Jul 2016 21:32:24 -0700
Subject: [GIT PULL v2] drivers: firmware: scpi updates for v4.8
In-Reply-To: <57697E82.7010009@arm.com>
References: <57697E82.7010009@arm.com>
Message-ID: <20160705043224.GI1669@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 06:50:58PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Here are few updates for SCPI drivers for v4.8.
> 
> The DT binding have been Acked by DT maintainer(Mark R)
> 
> Also as most of the genpd code is in drivers/soc and SCPI can be used on
> any SoC, runtime PM maintainers(Ulf and Kevin H) have agreed to keep the
> SCPI genpd based power domain driver in drivers/firmware for now.
> They have provided their Reviewed-by tags.
> 
> Please pull !
> 
> v1->v2:
> 	- Incorporated couple of minor nits suggested by Kevin
> 	- Added Kevin's Reviewed-by tag[1]
> 
> -- 
> Regards,
> Sudeep
> 
> [1] https://marc.info/?l=linux-kernel&m=146644540232320&w=2
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> tags/scpi-updates-4.8
> 
> for you to fetch changes up to 8bec4337ad4023b26de35d3b0c3a3b2735ffc5c7:
> 
>   firmware: scpi: add device power domain support using genpd (2016-06-21
> 10:26:51 +0100)
> 
> ----------------------------------------------------------------
> SCPI updates and fixes for v4.8
> 
> 1. Adds support for device power state management using generic power
>    domains and runtime PM
> 
> 2. Other minor/miscellaneous fixes to the driver

Merged, thanks.

-Olof
