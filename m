From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:06:59 -0700
Subject: [GIT PULL] STM32 DT changes for v4.13 #1
In-Reply-To: <2b77deee-6816-d58f-bc75-07cfd10e011e@st.com>
References: <2b77deee-6816-d58f-bc75-07cfd10e011e@st.com>
Message-ID: <20170619030659.GX30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 02:08:21PM +0200, Alexandre Torgue wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STM32 DT updates for v4.13:
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-dt-for-v4.13-1
> 
> for you to fetch changes up to 437074645873d77e8958be4f7eeec66a69cf0077:
> 
>   ARM: dts: stm32: Add stm32h743i-disco board (2017-06-09 16:38:42 +0200)
> 
> ----------------------------------------------------------------
> STM32 DT updates for v4.13, round 1
> 
> Highlights:
> ----------
>  - Add stm32h743-disco board support
>  - Add stm32f746-disco board support
>  - Add stm32f769-disco board support
>  - Enable LTDC & simple pannel on stm32f429-eval
>  - Enable Watchdog on stm32f429-eval
>  - Enable DCMI on stm32f429-eval
>  - Enable STMPE1600 io expander on stm32f429-eval
>  - Enable OV2640 camera on stm32f429-eval
>  - Enable CRC on stm32f429-eval & stm32f429-disco

Merged, thanks.

-Olof
