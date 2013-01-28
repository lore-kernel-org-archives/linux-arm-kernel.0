From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Jan 2013 08:45:03 +0000
Subject: [PATCH 25/26] mfd: ab8500-gpadc: Reduce conversion timeout
In-Reply-To: <20130127235339.GS1174@sortiz-mobl>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-26-git-send-email-lee.jones@linaro.org>
 <20130127235339.GS1174@sortiz-mobl>
Message-ID: <20130128084503.GC15873@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Samuel Ortiz wrote:

> Hi Lee,
> 
> On Tue, Jan 15, 2013 at 12:56:05PM +0000, Lee Jones wrote:
> > @@ -598,8 +601,6 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
> >  
> >  static int ab8500_gpadc_runtime_idle(struct device *dev)
> >  {
> > -	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> > -
> Unrelated change, please remove that part.

I'll fixup.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
