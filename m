From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 5 Jul 2016 10:15:35 -0600
Subject: [PATCH v2 1/2] coresight-etm3x: Add ARM ETM 3.5 Cortex-A5
 peripheral ID
In-Reply-To: <1467705950-29482-1-git-send-email-olivier.schonken@gmail.com>
References: <1467705950-29482-1-git-send-email-olivier.schonken@gmail.com>
Message-ID: <CANLsYkxdMwsmZWNfBqYjsOaTrG_j3E_VCMM6L-o=xra+dkzSLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 July 2016 at 02:05, Olivier Schonken <olivier.schonken@gmail.com> wrote:
> Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index d83ab82..0f5d400 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -885,6 +885,11 @@ static struct amba_id etm_ids[] = {
>                 .mask   = 0x0003ffff,
>                 .data   = "ETM 3.3",
>         },
> +       {       /* ETM 3.5 - Cortex-A5 */
> +               .id     = 0x0003b955,
> +               .mask   = 0x0003ffff,
> +               .data   = "ETM 3.5",
> +       },
>         {       /* ETM 3.5 */
>                 .id     = 0x0003b956,
>                 .mask   = 0x0003ffff,
> --
> 1.9.1
>

Applied - thanks.
Mathieu
