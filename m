From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 Jul 2018 11:33:58 -0700
Subject: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <20180709212522.187257-1-mka@chromium.org>
References: <20180709212522.187257-1-mka@chromium.org>
Message-ID: <CAD=FV=U0LezyVMLAQ5oXxBnO-sx4wGFe4KcBZpc=KCZNsYwpvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 9, 2018 at 2:25 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the spmi-temp-alarm node to pm8998 based on the examples in the
> bindings.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - changed node name from 'qcom,temp-alarm at 2400' to 'temp-alarm at 2400'
> - removed controller register length value from 'reg'
>
> Changes in v2:
> - none
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
