From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 8 May 2014 09:03:44 +0100
Subject: [PATCH 1/9] ARM: STi: DT: STiH416: 416 DT Entry for clockgen
 A0/1/10/11/12
In-Reply-To: <CAG374jD+msPPbPtFS+ji=8jS9+D-YHu31k7zzzC7Ty7jw9n7jQ@mail.gmail.com>
References: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
 <1399305223-18703-2-git-send-email-gabriel.fernandez@linaro.org>
 <20140506071843.GD5206@lee--X1>
 <CAG374jD+msPPbPtFS+ji=8jS9+D-YHu31k7zzzC7Ty7jw9n7jQ@mail.gmail.com>
Message-ID: <20140508080344.GE5307@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> Patch adds DT entries for clockgen A0/1/10/11/12
> >>
> >> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> >> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> >> ---
> >>  arch/arm/boot/dts/stih416-clks.h     |  15 ++
> >
> > This should live in include/dt-bindings/clk
> >
> include/dt-bindings/clk or  include/dt-bindings/clock ?

I have no idea what the difference between the two are.  I guess you
are in a better position to answer that.  My point was just that the
includes should be in the include directory, rather than being held
locally in the 'dts' directory.

> >>  arch/arm/boot/dts/stih416-clock.dtsi | 477 ++++++++++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/stih416.dtsi       |  10 +-
> >>  3 files changed, 497 insertions(+), 5 deletions(-)
> >>  create mode 100644 arch/arm/boot/dts/stih416-clks.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
