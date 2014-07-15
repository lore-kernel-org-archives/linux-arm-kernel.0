From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 15 Jul 2014 09:39:13 +0100
Subject: [PATCH v2 0/2] Support apq8064 global clock control
In-Reply-To: <1404980193-5967-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1402433906-19309-1-git-send-email-sboyd@codeaurora.org>
 <1404980193-5967-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <53C4E8B1.3040305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Could you please consider these patches for v3.17 as some of the drivers 
which require these clocks are already making there way to 3.17.


Thanks,
srini

On 10/07/14 09:16, Srinivas Kandagatla wrote:
> These two patches add full support for apq8064 in the global clock
> controller driver. The first patch has already been on the list so
> I've picked it up and resent because the second patch depends on it.
>
> Am resending the series with the fix to my patch.
>
> Changes since v1:
> 	- fixed comment log spotted by Andreas.
> 	- added few more sdcc clocks.
>
> Srinivas Kandagatla (1):
>    clk: qcom: add clocks necessary for apq8064 sdcc
>
> Stephen Boyd (1):
>    clk: qcom: Fully support apq8064 global clock control
>
>   drivers/clk/qcom/gcc-msm8960.c               | 583 ++++++++++++++++++++++++++-
>   include/dt-bindings/clock/qcom,gcc-msm8960.h |  11 +
>   include/dt-bindings/reset/qcom,gcc-msm8960.h |  16 +
>   3 files changed, 607 insertions(+), 3 deletions(-)
>
