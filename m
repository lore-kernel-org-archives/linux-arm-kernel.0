From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 Jul 2018 10:18:30 -0700
Subject: [PATCH v7 7/7] arm64: dts: sdm845: Add tsens nodes
In-Reply-To: <0dfdbfa82edced85ea5be02e1d74d73d232c7a08.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <0dfdbfa82edced85ea5be02e1d74d73d232c7a08.1531384019.git.amit.kucheria@linaro.org>
Message-ID: <CAD=FV=UHQ2SDC9WbS2=D_ka3OxnxPPrQt6tLx5Yy6Lf_bnVqrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> allow more common code.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
