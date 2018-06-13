From: evgreen@chromium.org (Evan Green)
Date: Wed, 13 Jun 2018 16:27:46 -0700
Subject: [PATCH] arm64: dts: qcom: Add pm8005 and pm8998 support
In-Reply-To: <20180613152054.54812-1-swboyd@chromium.org>
References: <20180613152054.54812-1-swboyd@chromium.org>
Message-ID: <CAE=gft4dFqR+hxLNsAVT6QZPuMMvV7-K-x_w8YXQogh5N00n7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 8:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add basic support for the pm8005 and pm8998 PMICs. For now just support
> the GPIO controllers.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8005.dtsi | 33 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 55 ++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8005.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8998.dtsi
>

Reviewed-by: Evan Green <evgreen@chromium.org>
