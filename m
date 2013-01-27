From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 28 Jan 2013 00:53:09 +0100
Subject: [PATCH 10/26] mfd: ab8500-debugfs: Wake-up device on debugfs IRQ
In-Reply-To: <1358254566-12419-11-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-11-git-send-email-lee.jones@linaro.org>
Message-ID: <20130127235309.GP1174@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jan 15, 2013 at 12:55:50PM +0000, Lee Jones wrote:
> Ensure the device wakes up if the debugfs IRQ fires if we're
> in suspend mode.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-debugfs.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
Please squash this one with the previous one.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
