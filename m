From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Jan 2017 10:39:50 -0800
Subject: [GIT PULL] STM32 DT changes for v4.11 #1 V2
In-Reply-To: <20170130053327.GB18943@localhost>
References: <a8f6b0aa-412e-65b7-5d88-e4b17097c3a8@st.com>
 <20170130053327.GB18943@localhost>
Message-ID: <20170130183950.GL8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29, Olof Johansson wrote:
> Hi Alexandre,
> 
> On Fri, Jan 20, 2017 at 03:40:41PM +0100, Alexandre Torgue wrote:
> > Hi Olof, Arnd and Kevin,
> > 
> > Please consider this second version of first round of STM32 DT updates for
> > v4.11:
> > 
> > The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> > 
> >   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> > tags/stm32-dt-for-v4.11-1-v2
> > 
> > for you to fetch changes up to a4e6964a78946bf3ce969d9fef5f201e0236f0ea:
> > 
> >   ARM: dts: stm32: enable RTC on stm32429i-eval (2017-01-20 14:59:58 +0100)
> > 
> > ----------------------------------------------------------------
> > STM32 DT updates for v4.11, round 1 Version 2.
> > 
> > Highlights:
> > ----------
> > 
> >  - ADD RTC support on STM32F429 MCU
> >  - Enable RTC on STM32F469and STM32F429 boards
> >  - ADD ADC support on STM32F429 MCU
> >  - Enable ADC on STM32F429 Eval board
> >  - Add I2S external clock
> >  - Fix memory size for STM32F429 Disco
> > 
> > Note:
> > -----
> > First patch "clk: stm32f4: Update DT bindings documentation")
> > has already been merged in clock tree. Compare to version 1
> > git merge has been used to take this patch.
> > 
> > ----------------------------------------------------------------
> > Alexandre TORGUE (1):
> >       Merge commit 'f8b5036361412a27c07a4ac9c3a4b80678cbd1e1' into
> > stm32-dt-for-v4.11
> 
> Hm, this is slightly odd, and I'm not entirely sure what goes on here. So
> please bear with me.
> 
> First, Stephen: This commit (f8b5036361412a27c07a4ac9c3a4b80678cbd1e1)
> sits on top of a "random" commit from my view,
> 2aab7a2055a1705c9e30920d95a596226999eb21 ("clk: bcm: Fix
> 'maybe-uninitialized' warning in bcm2835_clock_choose_div_and_prate()"). This
> isn't at an -rc*, and it's actually on a 4.9-rc base?!
> 
> Anyway, it doesn't really matter to me, as long as we know for sure that it's
> on a stable base that won't move. Stephen, please confirm!

That commit is stable. It's part of a stable branch called
clk-stm32f4 in the clk tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
