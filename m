From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Nov 2014 16:39:48 -0800
Subject: [GIT PULL] ARM: STi: DT changes for v3.19, round 1
In-Reply-To: <54537F9F.4070500@st.com>
References: <54537F9F.4070500@st.com>
Message-ID: <20141109003948.GF11947@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 01:25:03PM +0100, Maxime Coquelin wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STi DT updates for v3.19:
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.19-1
> 
> for you to fetch changes up to 43ca480c4e42f536fcf18118afcffad685e1292c:
> 
>   ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing
> (2014-10-31 12:07:44 +0100)
> 
> ----------------------------------------------------------------
> STi DT updates for v3.19, round 1.
> 
> Highlights:
> -----------
>  - Add SDHCI support for STiH41x B2020 boards
>  - Add reset controllers to STiH407 SoC
>  - Add MiPHY & SATA support to STiH416
>  - Add Thermal supportto STiH416
>  - Add Clock support to STiH407 SoC
> 
> This tag also includes STiH407 bindings definitions for reset controller.

Merged, thanks.


-Olof
