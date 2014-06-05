From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 09:17:42 +0100
Subject: [STLinux Kernel] [PATCH RESEND 03/12] drivers: clk: st: STiH407:
 Support for Flexgen Clocks
In-Reply-To: <1401892320-18211-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1401892320-18211-1-git-send-email-gabriel.fernandez@linaro.org>
 <1401892320-18211-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140605081742.GC3865@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jun 2014, Gabriel FERNANDEZ wrote:

> This patch is the Flexgen implementation reusing as much as possible
> of Common Clock Framework functions.
> 
> The idea is to have an instance of "struct flexgen" per output clock.
> It represents the clock cross bar (by a mux element), and the pre and final dividers
> (using dividers and gates elements).
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  drivers/clk/st/Makefile      |   2 +-
>  drivers/clk/st/clk-flexgen.c | 332 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 333 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/st/clk-flexgen.c

Acked-by: Peter Griffin <peter.griffin@linaro.org>
