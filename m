From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 Mar 2016 09:57:42 -0800
Subject: [PATCH 1/2] mmc: mediatek: Change signal voltage error to
 dev_dbg()
In-Reply-To: <1457000385-2317-1-git-send-email-drinkcat@chromium.org>
References: <1457000385-2317-1-git-send-email-drinkcat@chromium.org>
Message-ID: <CAD=FV=XEFHNrJrSruVSaWb8UnrZ9ud--ykj0n-PD3yr5Kbvh8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On Thu, Mar 3, 2016 at 2:19 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> In commit ceae98f20e36 ("mmc: core: Try other signal levels
> during power up") we can see that there are times when it's
> valid to try several signal voltages.  Don't print an ugly
> error in the logs when that happens.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>
> Similar to b19caf379c82e99737c29bc15d7b7fd7d24279f9
> mmc: dw_mmc: Change signal voltage error to dev_dbg()
>
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
