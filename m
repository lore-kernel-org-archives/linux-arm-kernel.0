From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:54:22 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.19, round 2
In-Reply-To: <7hr2jx50q0.fsf@baylibre.com>
References: <7hr2jx50q0.fsf@baylibre.com>
Message-ID: <20180721215422.vsd34udhkhs7lh3h@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 11:30:15AM -0500, Kevin Hilman wrote:
> Olof, Arnd,
> 
> A second round of DT updates for Amlogic, directly on top of the redo of
> the first one.
> 
> This includes a merge of a branch already queued in the clk tree because
> of the dependency on clock headers used in the DT changes here..
> 
> Kevin
> 
> 
> The following changes since commit 89803e8b26569bdf5798f8745a4c708bf9360ee6:
> 
>   ARM64: dts: meson-axg: add pdm pins (2018-07-20 08:18:37 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2
> 
> for you to fetch changes up to fcf775a1e6717b7157b1ea626028b7e039b3c989:
> 
>   Merge branch 'v4.19/dt64' into tmp/aml-rebuild (2018-07-20 09:05:11 -0700)
> 
> ----------------------------------------------------------------
> Amlogic 64-bit DT changes for v4.19, round 2
> - new SoC: S905W
> - new boards: based on S905W: Amlogic P281, Oranth Tanix TX3 Mini
> - AXG: add DT for new audio clock controller
> 
> ----------------------------------------------------------------

Something happened to your diffstat here. It's also based on -rc5?


-Olof
