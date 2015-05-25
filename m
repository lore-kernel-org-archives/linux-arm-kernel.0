From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 25 May 2015 12:21:09 -0600
Subject: [PATCH v2] coresight-etm3x: Add Qualcomm PTM v1.1 peripheral ID
In-Reply-To: <1432541717-32211-1-git-send-email-ivan.ivanov@linaro.org>
References: <1432541717-32211-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <CANLsYkw7GSkaP_+3RM19Pa115cXui_Te-WpFVvdb1jw1iFq6xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2015 at 02:15, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
> Add Qualcomm's PTM v1.1 peripheral ID to supported devices.
> This device could be found at least in MSM8974 and APQ8064
> chipsets.
>
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> ---
>
> Changes since v1:
>
> - s/PFT/PTM/ to describe device and not protocol implementation
>
>  drivers/hwtracing/coresight/coresight-etm3x.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 018a00f..cca98a8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -1912,6 +1912,11 @@ static struct amba_id etm_ids[] = {
>                 .mask   = 0x0003ffff,
>                 .data   = "PTM 1.1",
>         },
> +       {       /* PTM 1.1 Qualcomm */
> +               .id     = 0x0003006f,
> +               .mask   = 0x0003ffff,
> +               .data   = "PTM 1.1",
> +       },
>         { 0, 0},
>  };
>
> --
> 1.9.1
>

Applied - thanks.
