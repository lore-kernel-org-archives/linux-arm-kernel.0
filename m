From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Oct 2016 11:41:11 -0700
Subject: [GIT PULL] ARM: vexpress: fixes for v4.10
In-Reply-To: <20161028113003.GC12241@e107155-lin>
References: <20161028113003.GC12241@e107155-lin>
Message-ID: <20161029184111.GF4195@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 12:30:03PM +0100, Sudeep Holla wrote:
> Hi ARM SoC team,
> 
> These couple of fixes help to boot TC2 in HYP mode with CONFIG_MCPM
> enabled. This was not supported directly before and hence targeting for
> v4.10. Currently those who want to boot in HYP mode have to disable
> MCPM config in the build.
> 
> Please pull.
> 
> --
> Regards,
> Sudeep
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-fixes-4.10
> 
> for you to fetch changes up to 801f33be8e902d8cea75cb7ac056d07c4fdd25f8:
> 
>   drivers: cci: add missing CCI port availability firmware check (2016-10-17 14:27:54 +0100)

Merged, thanks.


-Olof
