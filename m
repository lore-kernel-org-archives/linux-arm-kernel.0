From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:49:01 -0700
Subject: [GIT PULL] firmware: scmi: updates for v4.18
In-Reply-To: <20180514162607.GC8409@e107155-lin>
References: <20180514162607.GC8409@e107155-lin>
Message-ID: <20180515204901.nqi4euifqa3wnor3@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 05:26:07PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Please pull !
> 
> Regards,
> Sudeep
> 
> --
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-updates-4.18
> 
> for you to fetch changes up to 632de8f542bcd44c756637da0e7d824e7129e496:
> 
>   firmware: arm_scmi: simplify exit path by returning on error (2018-05-10 10:52:00 +0100)
> 
> ----------------------------------------------------------------
> SCMI cleanups for v4.18
> 
> This contains all of the trivial review comments that were not
> addressed as the series was already queued up for v4.17 and were not
> critical to go as fixes.
> 
> They generally just improve code readability, fix kernel-docs, remove
> unused/unnecessary code, follow standard function naming and simplifies
> certain exit paths.

Nice! Merged into next/drivers now.


-Olof
