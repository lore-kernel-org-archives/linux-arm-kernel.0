From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Jul 2018 23:53:53 -0700
Subject: [Amlogic 64-bit DT updates for v4.19, round 2 (redo)
In-Reply-To: <7hy3e13mqx.fsf@baylibre.com>
References: <7hy3e13mqx.fsf@baylibre.com>
Message-ID: <20180726065353.5jn42f5m73g6hmrx@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 12:06:30PM -0500, Kevin Hilman wrote:
> [ fixes the original round 2 by removing the unnecessary (and wrong)
>   merge of v4.18-rc5.]
> 
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
> The following changes since commit 89803e8b26569bdf5798f8745a4c708bf9360ee6:
> 
>   ARM64: dts: meson-axg: add pdm pins (2018-07-20 08:18:37 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2-1
> 
> for you to fetch changes up to aaa080fa7e0f01f7cd8eb22a7385a4d8106c7478:
> 
>   ARM64: dts: meson-gxl: add support for the Oranth Tanix TX3 Mini (2018-07-20 09:02:22 -0700)
> 
> ----------------------------------------------------------------
> Amlogic 64-bit DT changes for v4.19, round 2
> - new SoC: S905W
> - new boards: based on S905W: Amlogic P281, Oranth Tanix TX3 Mini
> - AXG: add DT for new audio clock controller

Merged, thanks!


-Olof
