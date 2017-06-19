From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:10:13 -0700
Subject: [GIT PULL] STM32 defconfig changes for v4.13 #1
In-Reply-To: <a644e854-4b54-50dc-3779-8df6e3a8b02b@st.com>
References: <a644e854-4b54-50dc-3779-8df6e3a8b02b@st.com>
Message-ID: <20170619031013.GY30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 02:11:37PM +0200, Alexandre Torgue wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STM32 defconfig updates for v4.13:
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-defconfig-for-v4.13-1
> 
> for you to fetch changes up to d81cd7d72f6441df759c3db7adc69f4ad8d54fc4:
> 
>   ARM: configs: stm32: STMPE1600 GPIO expander (2017-06-08 14:59:05 +0200)
> 
> ----------------------------------------------------------------
> STM32 defconfig updates for v4.13, round 1
> 
> Highlights:
> ----------
>  - Enable STMPE1600 IO expander
>  - Enable Watchdog support

Thanks, merged.

-Olof
