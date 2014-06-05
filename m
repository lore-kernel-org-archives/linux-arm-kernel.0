From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 09:48:28 +0100
Subject: [STLinux Kernel] [PATCH RESEND 01/12] clk: st: Update ST clock
 binding documentation
In-Reply-To: <1401892320-18211-2-git-send-email-gabriel.fernandez@linaro.org>
References: <1401892320-18211-1-git-send-email-gabriel.fernandez@linaro.org>
 <1401892320-18211-2-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140605084828.GD3865@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jun 2014, Gabriel FERNANDEZ wrote:

> This patch adds new compatibilities to support STiH407 SoC.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  .../devicetree/bindings/clock/st/st,clkgen-mux.txt   |  2 +-
>  .../devicetree/bindings/clock/st/st,clkgen-pll.txt   |  5 ++++-
>  .../devicetree/bindings/clock/st/st,clkgen.txt       | 20 ++++++++++++++++----
>  .../devicetree/bindings/clock/st/st,quadfs.txt       |  3 +++
>  4 files changed, 24 insertions(+), 6 deletions(-)

Acked-by: Peter Griffin <peter.griffin@st.com>

Regards,

Peter
