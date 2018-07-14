From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 14:31:48 -0700
Subject: [GIT PULL] STM32 defconfig changes for v4.19 #1
In-Reply-To: <016b1449-4ede-9302-e6f9-c52b63e0330e@st.com>
References: <016b1449-4ede-9302-e6f9-c52b63e0330e@st.com>
Message-ID: <20180714213148.h2f3ipw6bja36x4p@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 04:01:40PM +0200, Alexandre Torgue wrote:
> Hi Arnd, Olof and Kevin,
> 
> Please consider this first round of STM32 defconfig updates for v4.19.
> This time it concerns only multi_v7_defconfig.
> 
> Thanks.
> Alex
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-defconfig-for-v4.19-1
> 
> for you to fetch changes up to 1b8a8589a3e10997fa8f43e7da874c4903f33ac7:
> 
>   ARM: multi_v7_defconfig: enable STM32 DCMI media support (2018-07-13
> 14:54:24 +0200)

Hi,

We renormalized the multi_v7_defconfig file in 4.18-rc3, so this pull request
has quite a few conflicts due to that. I've fixed it up though, make sure it's
behaving like you would expect.

Thanks,


-Olof
