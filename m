From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 14:49:49 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.18, round 3
In-Reply-To: <7hmuwqqk8k.fsf@baylibre.com>
References: <7hmuwqqk8k.fsf@baylibre.com>
Message-ID: <20180525214949.cwokqbzvl4f4jqdk@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 11:50:51AM -0700, Kevin Hilman wrote:
> Olof, ARnd,
> 
> Here's final round of 64-bit DT updates for v4.18 for Amlogic.
> 
> I separated this one from round 2 because I've merged a tag from the
> clock tree where the headers were added that are used by the new clock
> driver nodes.
> 
> That clock dependency branch is already queued by the clock maintainers,
> but included here so the arm-soc DT branch will continue to build
> standalone.
> 
> Kevin
> 
> The following changes since commit ffe2f2a415a5c36c0629c0ac8ea3dda80fbfd4b6:
> 
>   ARM64: dts: meson-axg: enable i2c AO on the S400 board (2018-05-23 10:05:41 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-3
> 
> for you to fetch changes up to 9adda3534faad306c3d5351c5b87d26fea9767be:
> 
>   ARM64: dts: meson: fix clock source of the pclk for UART_AO (2018-05-23 11:31:54 -0700)
> 
> ----------------------------------------------------------------
> Amlogic 64-bit DT updates, round3
> - AXG: add new clock driver

Merged, thanks!


-Olof
