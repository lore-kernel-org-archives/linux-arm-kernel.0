From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Jan 2015 13:12:36 -0700
Subject: [PATCH] coresight: remove the extra spaces
In-Reply-To: <1421308459-71865-1-git-send-email-xiakaixu@huawei.com>
References: <1421308459-71865-1-git-send-email-xiakaixu@huawei.com>
Message-ID: <CANLsYky1RZN8-kX==G159DSbSan=ZUOevs5taKABSrHaiPjLxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 00:54, Kaixu Xia <xiakaixu@huawei.com> wrote:
> There are some extra spaces, so just remove them from these lines.
>
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> ---
>  drivers/coresight/coresight-etb10.c | 2 +-
>  drivers/coresight/coresight.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/coresight/coresight-etb10.c b/drivers/coresight/coresight-etb10.c
> index c922d4a..d0529b5 100644
> --- a/drivers/coresight/coresight-etb10.c
> +++ b/drivers/coresight/coresight-etb10.c
> @@ -454,7 +454,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>         if (ret)
>                 return ret;
>
> -       drvdata->buffer_depth =  etb_get_buffer_depth(drvdata);
> +       drvdata->buffer_depth = etb_get_buffer_depth(drvdata);
>         clk_disable_unprepare(drvdata->clk);
>
>         if (drvdata->buffer_depth < 0)
> diff --git a/drivers/coresight/coresight.c b/drivers/coresight/coresight.c
> index 11968b7..0de0c39 100644
> --- a/drivers/coresight/coresight.c
> +++ b/drivers/coresight/coresight.c
> @@ -498,7 +498,7 @@ static int coresight_orphan_match(struct device *dev, void *data)
>          * Circle throuch all the connection of that component.  If we find
>          * an orphan connection whose name matches @csdev, link it.
>          */
> -       for (i = 0; i < i_csdev->nr_outport; i++)       {
> +       for (i = 0; i < i_csdev->nr_outport; i++) {
>                 conn = &i_csdev->conns[i];
>
>                 /* We have found at least one orphan connection */
> --
> 1.8.5.5
>

Applied - thanks.
