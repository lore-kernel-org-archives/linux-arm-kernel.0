From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:29:01 -0800
Subject: [GIT PULL] STi DT update for v4.10 round 2
In-Reply-To: <828ebfb1-7ed0-8e6b-116d-9ef74d804db6@st.com>
References: <828ebfb1-7ed0-8e6b-116d-9ef74d804db6@st.com>
Message-ID: <20161118072901.GF1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 10:00:48AM +0100, Patrice Chotard wrote:
> Hi Arnd, Kevin, Olof
> 
> PLease consider this second round of STi dts update for v4.10 :
> 
> The following changes since commit 97a0b97f9e8197429eee5f87ce14373f73dbd9d3:
> 
>   ARM: dts: stih410-clocks: Add PROC_STFE as a critical clock (2016-10-20 16:20:26 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-4.10-round2
> 
> for you to fetch changes up to 64783ea7de0bff3de77cfdff1ed76428c288faac:
> 
>   ARM: dts: STiHxxx-b2120: change sound card name (2016-11-10 09:52:49 +0100)
> 
> ----------------------------------------------------------------
> STi dts update:
> 
> Change sound card name for B2120
> Enable sound card for B2260
> Remove stih415-clks.h
> Identify critical clocks for STiH407
> Fix typo in stih407-pinctrl.dtsi
> 
> ----------------------------------------------------------------
> Arnaud Pouliquen (2):
>       ARM: dts: STiH410-B2260: enable sound card
>       ARM: dts: STiHxxx-b2120: change sound card name
> 
> Geert Uytterhoeven (1):
>       ARM: dts: STiH407: DT fix s/interrupts-names/interrupt-names/
> 
> Patrice Chotard (1):
>       ARM: dts: remove stih415-clks.h
> 
> Peter Griffin (1):
>       ARM: dts: stih407-clocks: Identify critical clocks
> 
>  arch/arm/boot/dts/stih407-clock.dtsi     | 10 ++++++++++
>  arch/arm/boot/dts/stih407-pinctrl.dtsi   |  2 +-
>  arch/arm/boot/dts/stih410-b2260.dts      | 22 ++++++++++++++++++++++
>  arch/arm/boot/dts/stihxxx-b2120.dtsi     |  2 +-
>  include/dt-bindings/clock/stih415-clks.h | 16 ----------------
>  5 files changed, 34 insertions(+), 18 deletions(-)
>  delete mode 100644 include/dt-bindings/clock/stih415-clks.h
> 
> 
> 

Merged, thanks!


-Olof
