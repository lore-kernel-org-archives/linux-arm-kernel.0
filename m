From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 18:11:00 -0700
Subject: [GIT PULL 3/5] ARM: tegra: device tree updates
In-Reply-To: <1371227838-18764-4-git-send-email-swarren@wwwdotorg.org>
References: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
 <1371227838-18764-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130615011100.GQ18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 10:37:16AM -0600, Stephen Warren wrote:
> This branch contains all device tree updates for Tegra boards.
> 
> The changes are:
> 
> * Converted all DT files to use the C pre-processor, to support the use
>   of named constants. This included use of defines for GPIO, IRQ, and
>   clock constants.
> * Enabling new features such as:
>   - SPI on Dalmore.
>   - Audio on Dalmore and Beaver.
>   - gpio-leds on Beaver.
>   - Power-supply/batter linkage on Dalmore.
> * A minor fix to the RAM size node on Beaver.
> 
> It is based on previous pull request tegra-for-3.11-deps-for-usb
> followed by a merge of tegra-for-3.11-deps-for-clk.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 220cf5fb5c9eeef49930ff6fca2943286ec075a4:
> 
>   Merge branch 'for-3.11/deps-for-clk' into for-3.11/dt
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.11-dt

Thanks, pulled. It was good to see the two previous broken out but I ended up
just pulling it all with this one.


-Olof
