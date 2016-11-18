From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 10:36:31 -0800
Subject: [GIT PULL] STM32 SOC changes for v4.10 #1
In-Reply-To: <7e258e38-5ac9-60e8-4bc7-03acedd5e11d@st.com>
References: <7e258e38-5ac9-60e8-4bc7-03acedd5e11d@st.com>
Message-ID: <20161118183631.GI8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 15, 2016 at 03:22:30PM +0100, Alexandre Torgue wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STM32 SOC updates for v4.10:
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/soc-for-4.10-1
> 
> for you to fetch changes up to 6bc18b83c0c3b5d56137a31ce98ca2802036e7a9:
> 
>   ARM: Kconfig: Introduce MACH_STM32F746 flag (2016-11-15 12:02:59 +0100)
> 
> ----------------------------------------------------------------
> STM32 SOC updates for v4.10, round 1.
> 
> Highlights:
> ----------
>  - Add new MCU SOC STM32F746
> 
> ----------------------------------------------------------------
> Alexandre TORGUE (2):
>       ARM: mach-stm32: Add a new SOC - STM32F746
>       ARM: Kconfig: Introduce MACH_STM32F746 flag

Merged. For future patches, please use the same format as other platforms,
in your case it would be:

ARM: stm32: <..>

I.e. others are leaving out the mach- part.

Also, on the Kconfig change, please consider adding a Kconfig under your
mach directory and include it. We ask most platforms that have suboptions
to do this to avoid conflicts and provide a bit more structure. Feel
free to send a new pull request build on top of this one for that,
since we're merging this one now.


Thanks!


-Olof
