From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 23 Nov 2012 10:34:01 +0000
Subject: [PATCH v4 04/11] pwm: pwm-tiecap: Add device-tree binding
 support for APWM driver
In-Reply-To: <20121122205732.GB16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-5-git-send-email-avinashphilip@ti.com>
 <20121122205732.GB16716@avionic-0098.adnet.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE98C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:27:33, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:41:01PM +0530, Philip, Avinash wrote:
> [...]
> > +static const struct of_device_id ecap_of_match[] = {
> > +	{
> > +		.compatible	= "ti,am33xx-ecap",
> > +	},
> 
> Same here, can be shorter by putting it on one line instead of three.

I will correct it

Thanks
Avinash
> 
> Thierry
> 
