From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 18 Mar 2015 17:41:59 +0100
Subject: [STLinux Kernel] [PATCH 3/6] pinctrl: st: Move
 st_get_pio_control() further up the source file
In-Reply-To: <1426675899-19882-4-git-send-email-lee.jones@linaro.org>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
 <1426675899-19882-4-git-send-email-lee.jones@linaro.org>
Message-ID: <5509AAD7.8030300@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2015 11:51 AM, Lee Jones wrote:
> st_get_pio_control() will be used by subsequent calls which are
> to be located above its original position.  This is required to
> prevent the need for an unnecessary forward-declaration/prototype.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/pinctrl/pinctrl-st.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
