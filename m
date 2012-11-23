From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 23 Nov 2012 10:34:01 +0000
Subject: [PATCH v4 01/11] PWMSS: Add PWM Subsystem driver for
 parent<->child relationship
In-Reply-To: <20121122204704.GA16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-2-git-send-email-avinashphilip@ti.com>
 <20121122204704.GA16716@avionic-0098.adnet.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE987@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:17:04, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:40:58PM +0530, Philip, Avinash wrote:
> [...]
> > +static const struct of_device_id pwmss_of_match[] = {
> > +	{
> > +		.compatible	= "ti,am33xx-pwmss",
> > +	},
> 
> For consistency with other drivers this should be all on one line.

Ok I will correct it.

> 
> > +static const struct dev_pm_ops pwmss_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(pwmss_suspend, pwmss_resume)
> > +};
> 
> This could be even shorter:
> 
> static SIMPLE_DEV_PM_OPS(pwmss_pm_ops, pwmss_suspend, pwmss_resume);

Ok I will correct it.

Thanks
Avinash

> 
> Thierry
> 
