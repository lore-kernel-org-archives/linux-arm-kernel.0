From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 14:55:46 -0700
Subject: [GIT PULL] ARM: imx: soc changes for 3.16
In-Reply-To: <20140516151158.GC10685@dragon>
References: <20140516151158.GC10685@dragon>
Message-ID: <20140521215546.GH24972@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 11:12:00PM +0800, Shawn Guo wrote:
> The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:
> 
>   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.16
> 
> for you to fetch changes up to 46ae42498ef6febdaa6b51359f1ede38cd6b5a47:
> 
>   ARM: mx25: Add CLKO support (2014-05-16 22:51:34 +0800)
> 
> ----------------------------------------------------------------
> i.MX SoC changes for 3.16:
>  - A few cleanups on mx21ads board file, which should make the later
>    conversion to DT a little bit easier.
>  - Add some missing clocks and drop unused clk lookups for i.MX1 and
>    i.MX27 clock drivers
>  - Add initial i.MX SoloX (imx6sx) SoC support
>  - Remove mx51_babbage and mach-cpuimx51sd board files, as the
>    equivalent DT support is ready for the boards
>  - Clean up device tree timer initialization a little bit
>  - Add missing i2c4 clock for i.MX6 DualLite/Solo
>  - Add missing CKO clock i.MX25
>  - Add shared gate clock support for i.MX specific clk_gate2
>  - Add low-level debug support for SoC VF610
>  - Some random code cleanups and defconfig updates

Hi,

Pulled into next/soc, but I think you should have split some of the
above up into a cleanup branch that you could use as a base for this
and a board branch if needed.


-Olof
