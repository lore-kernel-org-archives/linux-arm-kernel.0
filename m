From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 18 Mar 2015 17:45:08 +0100
Subject: [STLinux Kernel] [PATCH 5/6] pinctrl: st: Show correct pin
 direction -- even when in GPIO mode
In-Reply-To: <1426675899-19882-6-git-send-email-lee.jones@linaro.org>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
 <1426675899-19882-6-git-send-email-lee.jones@linaro.org>
Message-ID: <5509AB94.8040100@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2015 11:51 AM, Lee Jones wrote:
> Until now ST's pinconf_dbg_show() call-back has displayed the PIO
> alternate function direction, which is only relevant if a pin is
> operating in an alternate function mode i.e not GPIO mode.  If a
> pin is in GPIO mode its direction is both set and status is
> obtained by a completely different/unrelated bunch of registers.
>
> This change ensures that the correct pin direction is shown, even
> if a pin is operating in GPIO mode.
>
> Reported-by: Olivier Clergeaud <olivier.clergeaud@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/pinctrl/pinctrl-st.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
>


Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
