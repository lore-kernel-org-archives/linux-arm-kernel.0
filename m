From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 12 Mar 2018 14:11:00 +0000
Subject: [PATCH] mfd: ab8500-debugfs: Use kasprintf
In-Reply-To: <1520445961-12160-1-git-send-email-himanshujha199640@gmail.com>
References: <1520445961-12160-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <20180312141100.brfyw3kn5meamfcv@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Mar 2018, Himanshu Jha wrote:

> Use kasprintf instead of combination of kmalloc and sprintf.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/mfd/ab8500-debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
