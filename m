From: dianders@chromium.org (Doug Anderson)
Date: Thu, 6 Sep 2018 14:09:44 -0700
Subject: [PATCH v2 2/3] arm64: dts: qcom: pm8998: Add adc node
In-Reply-To: <20180906210454.247219-3-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
 <20180906210454.247219-3-mka@chromium.org>
Message-ID: <CAD=FV=XTbkfF0fTot_ebqD+ohbgQBYKVwHTZunuoxC7uGYN9Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the adc node to pm8998 based on the examples in the
> bindings. It also fixes the order of the included headers.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> --
> Changes in v2:
> - removed io-channel-ranges attribute
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
