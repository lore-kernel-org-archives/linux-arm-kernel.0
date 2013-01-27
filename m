From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 28 Jan 2013 00:53:39 +0100
Subject: [PATCH 25/26] mfd: ab8500-gpadc: Reduce conversion timeout
In-Reply-To: <1358254566-12419-26-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-26-git-send-email-lee.jones@linaro.org>
Message-ID: <20130127235339.GS1174@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jan 15, 2013 at 12:56:05PM +0000, Lee Jones wrote:
> @@ -598,8 +601,6 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
>  
>  static int ab8500_gpadc_runtime_idle(struct device *dev)
>  {
> -	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> -
Unrelated change, please remove that part.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
