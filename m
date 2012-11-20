From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 20 Nov 2012 08:37:18 +0530
Subject: [PATCH 055/493] dma: remove use of __devexit_p
In-Reply-To: <1353349642-3677-55-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-55-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAOh2x=mLx+iVEF89LwDcEt0pvbiq6HKmoPRVeOUnvmdUps00nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:50 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/dma/dw_dmac.c         | 2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
