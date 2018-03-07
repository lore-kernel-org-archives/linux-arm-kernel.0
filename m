From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:12:16 +0100
Subject: [GIT PULL] STM32 SOC changes for v4.17 #1
In-Reply-To: <d283d515-5f73-2207-9ed7-d554ddb673ae@st.com>
References: <d283d515-5f73-2207-9ed7-d554ddb673ae@st.com>
Message-ID: <CAK8P3a0w4Wj7fyqrt5XTCO6G7_qg3fQzeO6eCRLoSDQs6H2QKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 12:15 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Arnd, Olof and Kevin,
>
> Please consider this first round of STM32 SOC updates for v4.17:
>
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-soc-for-v4.17-1
>
> for you to fetch changes up to 2092e3adc323695255bd06d65f14c89afb5727ae:
>
>   ARM: stm32: restore reboot capabilities (2018-03-05 09:11:58 +0100)
>
> ----------------------------------------------------------------
> STM32 SOC updates for v4.17, round 1.
>
> Highlights:
> ----------
>  -Add STM32F769 MCU support
>  -Add STM32MP157 MPU support
>  -Add AMBA PL180 MMCI support for F4 and F7 MCUs
>  -Move STM32 documentation to rst format

It would have been good to get a little more explanation about what the various
added chips are, since I try to distill the information into my own changelogs
for the pull request to Linus.

The added documentation files contain all the information of course,
so I'll use that.

        Arnd
