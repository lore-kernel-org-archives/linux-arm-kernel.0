From: evgreen@chromium.org (Evan Green)
Date: Fri, 3 Aug 2018 15:59:42 -0700
Subject: [PATCH v7 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
In-Reply-To: <20180731161340.13000-7-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-7-georgi.djakov@linaro.org>
Message-ID: <CAE=gft6eTnCm2CoUkhG8COHC+rMdrWGf2A+PqZYB+gq4djm5xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add driver for the Qualcomm interconnect buses found in msm8916 based
> platforms.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/Kconfig        |   5 +
>  drivers/interconnect/Makefile       |   1 +
>  drivers/interconnect/qcom/Kconfig   |   9 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8916.c | 510 ++++++++++++++++++++++++++++
>  5 files changed, 527 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>

Reviewed-by: Evan Green <evgreen@chromium.org>
