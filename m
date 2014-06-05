From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 10:01:40 +0100
Subject: [STLinux Kernel] [PATCH RESEND 10/12] drivers: clk: st: STiH407:
 Support for clockgenA9
In-Reply-To: <1401892320-18211-11-git-send-email-gabriel.fernandez@linaro.org>
References: <1401892320-18211-1-git-send-email-gabriel.fernandez@linaro.org>
 <1401892320-18211-11-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140605090140.GB9977@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jun 2014, Gabriel FERNANDEZ wrote:

> The patch added support for DT registration of ClockGenA9
> It includes c32 type PLL.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
> ---
>  drivers/clk/st/clkgen-pll.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Peter Griffin <peter.griffin@linaro.org>

Regards,

Peter
