From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:05:06 -0700
Subject: [GIT PULL] firmware: scmi: fixes for v4.17 (part 2)
In-Reply-To: <20180511132942.GA18590@e107155-lin>
References: <20180511132942.GA18590@e107155-lin>
Message-ID: <20180514080506.v6svbjukel23os6y@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 02:29:42PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Please pull !
> 
> Regards,
> Sudeep
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-fixes-4.17
> 
> for you to fetch changes up to 31c6085562a03124d3f6a5c43dd9888ac44495a5:
> 
>   firmware: arm_scmi: Use after free in scmi_create_protocol_device() (2018-05-08 18:03:47 +0100)
> 
> ----------------------------------------------------------------
> SCMI fix for v4.17
> 
> A single patch to ensure that the scmi device is not used for setting up
> scmi handle after it's freed(fixes use after free).

Merged, thanks.


-Olof
