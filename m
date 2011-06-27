From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 27 Jun 2011 16:42:16 +0530
Subject: [PATCH V2 0/3] Add drivers/pwm and drivers/pwm/st_pwm.c
In-Reply-To: <cover.1306831238.git.viresh.kumar@st.com>
References: <cover.1306831238.git.viresh.kumar@st.com>
Message-ID: <4E086590.8080100@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2011 02:21 PM, Viresh KUMAR wrote:
> This patchset adds drivers/pwm directory as suggested by Arnd Bergmann in
> following discussion:
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/118651
> 
> and also adds support for ST Microelectronics Pulse Width Modulator. This is
> currently used by ST's SPEAr platform and tested on the same.
> 
> Changes since V1:
>  - Moved driver to drivers/pwm/ directory from drivers/misc
>  - arch/arm/configs/spear3xx_defconfig updated accordingly.
> 
> Changes since earlier patchset:
>  - Moved driver to drivers/misc/ directory.
> 
> It was earlier reviewed as part of following patchset:
> "[PATCH V6 00/17] Adding devices support for all spear machines"
> 
> Viresh Kumar (3):
>   drivers/pwm st_pwm: Add support for ST's Pulse Width Modulator
>   SPEAr3xx: Add machine support for ST's PWM IP
>   SPEAr3xx: Update defconfig for ST's PWM
> 

Hi Arnd,

Will you push this patchset through your tree or somebody else will do?

-- 
viresh
