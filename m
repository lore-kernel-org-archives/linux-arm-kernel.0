From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 20 Nov 2012 08:37:54 +0530
Subject: [PATCH 226/493] dma: remove use of __devinit
In-Reply-To: <1353349642-3677-226-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-226-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAOh2x=mM5E4+cmgaO4PZjyCp3EDixev5A+rNGw0WJ2G5WRVJ4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:52 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Zhang Wei <zw@zh-kernel.org>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/dma/dw_dmac.c         | 4 ++--

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
