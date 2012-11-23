From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 23 Nov 2012 10:35:01 +0000
Subject: [PATCH v4 06/11] pwm: pwm-tiehrpwm: Add device-tree binding
 support for EHRPWM driver
In-Reply-To: <20121122210347.GD16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-7-git-send-email-avinashphilip@ti.com>
 <20121122210347.GD16716@avionic-0098.adnet.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE9A4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:33:47, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:41:03PM +0530, Philip, Avinash wrote:
> [...]
> > +static const struct of_device_id ehrpwm_of_match[] = {
> > +	{
> > +		.compatible	= "ti,am33xx-ehrpwm",
> > +	},
> 
> Same comment as for patch 4.

Ok I will correct it.

> 
> > @@ -437,16 +451,41 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
> >  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> >  		return ret;
> >  	}
> > -
> 
> I think this blank line actually improves readability so it can stay in.

I will add.

Thanks
Avinash

> 
> Thierry
> 
