From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 30 Sep 2015 11:13:18 +0200
Subject: [PATCH] ARM: STi: DT: STiH407: Rename incorrect interrupt related
 binding
In-Reply-To: <1443516738-3569-1-git-send-email-lee.jones@linaro.org>
References: <1443516738-3569-1-git-send-email-lee.jones@linaro.org>
Message-ID: <560BA7AE.20103@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 09/29/2015 10:52 AM, Lee Jones wrote:
> interrupts-names => interrupt-names
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-pinctrl.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
>

Good spot!
Applied to sti-dt-for-v4.4.

thanks,
Maxime
