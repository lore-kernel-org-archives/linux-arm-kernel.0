From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Oct 2017 10:31:15 -0700
Subject: [GIT PULL] STM32 DT fixes for v4.14
In-Reply-To: <ec743780-6c16-ada9-3e0a-335758c989df@st.com>
References: <ec743780-6c16-ada9-3e0a-335758c989df@st.com>
Message-ID: <CAOesGMgbsJFN46ADtd97DCzsRokZLVQ6Y6PVgFUKXPn0f9KKmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 7:08 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Arnd, Kevin and Olof,
>
> Please consider this round of STM32 DT fixes for v4.14:
>
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-dt-fixes-for-v4.14
>
> for you to fetch changes up to 2aaae13a9db7897a007c5d7bb46cacfb37dffacd:
>
>   ARM: dts: stm32: use right pinctrl compatible for stm32f469 (2017-10-04
> 15:34:48 +0200)
>
> ----------------------------------------------------------------
> STM32 fixes for v4.14:
> ---------------------
>
> -Fix STMPE1600 bindings for stm32429i-eval board
> -Use right compatible for stm32f469 pinctrl. It implies to use
> pinctrl dedicated files for F4 SoCs.

Merged, thanks.


-Olof
