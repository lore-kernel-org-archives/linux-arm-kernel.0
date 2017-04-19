From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 05:29:56 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.12 (redo)
In-Reply-To: <m24ly37kzk.fsf@baylibre.com>
References: <m24ly37kzk.fsf@baylibre.com>
Message-ID: <20170419122956.GK17004@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 05:31:59PM -0700, Kevin Hilman wrote:
> Hi Arnd, Olof,
> 
> Here's a redo of the Amlogic 64-bit DT updates for v4.12.
> 
> This DT branch includes all our DT updates, plus merges in a clock
> branch that includes only clock header and binding updates which are
> dependencies.  This shared branch/tag is immutable and shared with the
> clock tree.
> 
> I hope this iteration passes muster,
> 
> Kevin
> 
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-redo
> 
> for you to fetch changes up to b2121170143bf4708c657461740c922ce24bc94e:
> 
>   Merge tag 'amlogic-clk-headers' into v4.12/dt64 (2017-04-04 16:16:52 -0700)
> 
> ----------------------------------------------------------------
> Amlogic 64-bit DT updates for v4.12
> - pinctrl: new pins for audio
> - clocks: more clocks exposed for GFX, audio
> - new board: Khadas Vim (S905X)
> - new board: HwaCom AmazeTV (S905X)
> - ethernet phy: add GPIO resets

Merged, thanks.


-Olof
