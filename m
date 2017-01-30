From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:06:04 -0800
Subject: [GIT PULL 4/4] TI DaVinci defconfig updates for v4.11
In-Reply-To: <20170124130641.28264-4-nsekhar@ti.com>
References: <20170124130641.28264-1-nsekhar@ti.com>
 <20170124130641.28264-4-nsekhar@ti.com>
Message-ID: <20170130010604.GT3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 06:36:41PM +0530, Sekhar Nori wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/defconfig
> 
> for you to fetch changes up to 685db57ace04411387b33e607d6abde9763819e7:
> 
>   ARM: davinci_all_defconfig: enable iio (2017-01-20 17:21:03 +0530)
> 
> ----------------------------------------------------------------
> Enable config options for DaVinci
> VPIF, LCDC, PWM, Pull up/down pinconf
> driver and IIO in davinci_all_defconfig
> 
> ----------------------------------------------------------------
> Bartosz Golaszewski (1):
>       ARM: davinci_all_defconfig: enable dumb vga-dac drm bridge
> 
> David Lechner (4):
>       ARM: davinci_all_defconfig: enable pwm-beeper
>       ARM: davinci_all_defconfig: enable DA8xx pinconf
>       ARM: davinci_all_defconfig: Enable PWM modules
>       ARM: davinci_all_defconfig: enable iio
> 
> Kevin Hilman (1):
>       ARM: davinci_all_defconfig: enable video capture as modules

Merged, thanks!


-Olof
