From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 30 Apr 2015 13:12:41 +0200
Subject: [STLinux Kernel] [PATCH v7 4/9] ARM: STi: DT: STiH407: Add Device
 Tree node for the LPC
In-Reply-To: <1428590854-14095-5-git-send-email-lee.jones@linaro.org>
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
 <1428590854-14095-5-git-send-email-lee.jones@linaro.org>
Message-ID: <55420E29.2050504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/09/2015 04:47 PM, Lee Jones wrote:
> On current ST platforms the LPC controls a number of functions.  This
> patch enables support for the LPC Watchdog and LPC RTC devices on LPC1
> and LPC2 respectively.
>
> Signed-off-by: David Paris <david.paris@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
>

Applied to sti-dt-for-v4.2.

Thanks!
Maxime
