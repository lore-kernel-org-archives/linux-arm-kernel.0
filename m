From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 06:36:40 -0700
Subject: [GIT PULL] STM32 DT changes for v4.20 #1
In-Reply-To: <fd4ee9a6-8195-084c-c60e-6c6e11649a4a@st.com>
References: <fd4ee9a6-8195-084c-c60e-6c6e11649a4a@st.com>
Message-ID: <20180923133640.rkc4rhk7px4qb65a@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 04:15:33PM +0200, Alexandre Torgue wrote:
> Hi Arnd, Olof and Kevin,
> 
> Please consider this first round of STM32 DT updates for v4.20.
> 
> Thanks.
> Alex
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> stm32-dt-for-v4.20-1
> 
> for you to fetch changes up to 1ba23b1df0bb6eec430408614c3a11280941e112:
> 
>   ARM: dts: stm32: Fix SPI controller node names (2018-09-21 16:09:52 +0200)
> 
> ----------------------------------------------------------------
> STM32 DT updates for v4.20, round 1
> 
> Highlights:
> ----------
> 
> -MCU platforms update:
>  -Add missing clock node's lobel on stm32f429
>  -Remove cd-inverted property for sdio nodes for
>   all mcus
>  -Fix stm32h7 rtc binding
> 
> -MPU STM32MP157 platform update:
>  -Enable display: CEC and DSI
>  -Fix SPI node name to match with the new DTC

Thanks, merged!


-Olof
