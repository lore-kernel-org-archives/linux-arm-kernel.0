From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:47:42 -0700
Subject: [GIT PULL] ARM: dts: vexpress: updates for v4.18
In-Reply-To: <20180514162144.GA8409@e107155-lin>
References: <20180514162144.GA8409@e107155-lin>
Message-ID: <20180515204742.3pptod2a5w6fpawx@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 05:21:44PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Please pull !
> 
> Note that the commit restructuring motherboard dtsi touches the file
> in ARM64 DT but that's because of the way the file gets included and
> it's not something newly introduced here.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-updates-4.18
> 
> for you to fetch changes up to b67b00eeddac0fea494d6339618ffd3da071c2e4:
> 
>   ARM: dts: vexpress: replace '_' with '-' in node names (2018-05-11 14:12:32 +0100)
> 
> ----------------------------------------------------------------
> ARMv7 Vexpress updates/cleanups for v4.18
> 
> 1. Syntactic restructuring of motherboard include file so that it can be
>    included at the top of any other DTS file as it should be rather than
>    existing include in the middle of the file at a specific location
> 
> 2. Use of standard GPIO controller bindings for few sysreg components
>    like LED, MMC Write Protect/Card Detect and Flash Write Protect
>    to fix some of the new DTC warnings
> 
> 3. Cleanup to replace all underscores('_') with hyphens('-') in the
>    device node names

Merged, thanks!


-Olof
