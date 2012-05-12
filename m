From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 May 2012 21:42:01 +0000
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
Message-ID: <201205122142.02318.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 May 2012, viresh kumar wrote:
> The following changes since commit 9f05a80564c35c397c5ce0f0b1106a420c3f5bdc:
> 
>   SPEAr: Update defconfigs (2012-05-10 16:15:08 +0530)
> 
> are available in the git repository at:
> 
>   git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-pinctrl-update
> 
> for you to fetch changes up to 560a7694d63e2461912d3b99987a3c89ea4b56e2:
> 
>   SPEAr: Add plgpio node in device tree dtsi files (2012-05-10 16:15:09 +0530)
> 
> ----------------------------------------------------------------
> Viresh Kumar (6):
>       gpiolib: Add of_get_gpio_chip_by_phandle() helper
>       pinctrl: SPEAr: Don't set all non muxreg bits on pinctrl_disable
>       pinctrl: SPEAr1310: Fix pin numbers for clcd_high_res
>       pinctrl: SPEAr: Add plgpio driver
>       pinctrl: SPEAr: Add gpio ranges support
>       SPEAr: Add plgpio node in device tree dtsi files

Hi Viresh,

I thought the first patch "gpiolib: Add of_get_gpio_chip_by_phandle() helper"
was not actually accepted. What was the outcome of that discussion?

	Arnd
