From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 12:32:23 +0100
Subject: [STLinux Kernel] [PATCH RESEND 08/12] drivers: clk: st: STiH407:
 Support for clockgenC0
In-Reply-To: <1401892320-18211-9-git-send-email-gabriel.fernandez@linaro.org>
References: <1401892320-18211-1-git-send-email-gabriel.fernandez@linaro.org>
 <1401892320-18211-9-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140605113223.GC11244@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jun 2014, Gabriel FERNANDEZ wrote:

> The patch added support for DT registration of ClockGenC0
> It includes 2 c32 type PLL and a 660 Quadfs.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
> ---
>  drivers/clk/st/clkgen-fsyn.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/st/clkgen-pll.c  | 32 ++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)

Acked-by: Peter Griffin <peter.griffin@linaro.org>

Regards,

Peter
