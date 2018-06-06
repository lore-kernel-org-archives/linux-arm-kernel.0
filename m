From: dianders@chromium.org (Doug Anderson)
Date: Wed, 6 Jun 2018 15:59:02 -0700
Subject: [PATCH v6 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <38cb1906c96504f74517018ca4e0aed63bb77356.1528138319.git.collinsd@codeaurora.org>
References: <cover.1528138319.git.collinsd@codeaurora.org>
 <38cb1906c96504f74517018ca4e0aed63bb77356.1528138319.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=X_b0nuGzccTg03WOaNQ81nCtJ2=98btoVf7AQ1W-mkMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 4, 2018 at 12:15 PM, David Collins <collinsd@codeaurora.org> wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +++++
>  2 files changed, 196 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
