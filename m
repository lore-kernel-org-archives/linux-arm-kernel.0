From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 9 Dec 2010 18:03:57 +0100
Subject: [PATCH 13/20] mfd/tc3589x: add suspend/resume support
In-Reply-To: <1291388753-14662-14-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-14-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20101209170356.GY8884@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sundar,

On Fri, Dec 03, 2010 at 08:35:46PM +0530, Sundar Iyer wrote:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

One remark though:
> +
> +static const struct dev_pm_ops tc3589x_dev_pm_ops = {
> +	.suspend = tc3589x_suspend,
> +	.resume  = tc3589x_resume,
> +};
> +#endif
SIMPLE_DEV_PM_OPS or UNIVERSAL_DEV_PM_OPS may be useful and save one ifdef
here.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
