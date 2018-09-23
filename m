From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 06:23:43 -0700
Subject: [GIT PULL] Amlogic ARM64 DT updates for v4.20
In-Reply-To: <7hva79uva5.fsf@baylibre.com>
References: <7hva79uva5.fsf@baylibre.com>
Message-ID: <20180923132343.3x5cng7c7peetzak@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 11:06:26AM -0700, Kevin Hilman wrote:
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64
> 
> for you to fetch changes up to 445f2bda3501508b801b3571baee33de0ac44e1f:
> 
>   arm64: dts: meson: Switch simple-mfd and syscon order (2018-09-13 09:16:36 -0700)
> 
> ----------------------------------------------------------------
> Amlogic ARM64 DT updates for v4.20
> - AXG: cleanup/reorder nodes
> - AXG: add audio PDM support for s400 board
> - GX: increase CMA memory size
> - GX: new canvas driver

Addition of the canvas hardware for the new driver to use, more likely?

Anyway, just nitpicking on wording, this looks reasonable to me -- merged.


-Olof
