From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 2 Jan 2013 11:09:27 +0000
Subject: [RFC v2 01/18] mailbox: OMAP2+: Add support for AM33XX
In-Reply-To: <20130101182506.GD22106@atomide.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-2-git-send-email-vaibhav.bedia@ti.com>
 <20130101182506.GD22106@atomide.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECCBFD0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, Jan 01, 2013 at 23:55:06, Tony Lindgren wrote:
[...]
> >  
> >  	mbox_write_reg(bit, p->irqdisable);
> 
> The cpu_is/soc_is macros are no longer available to drivers
> with 8d91a42e (Merge tag 'omap-late-cleanups'...). So you'll
> have to pass whatever flags the driver needs in platform_data
> or as device tree properties.
> 

Thanks for the heads-up. Will rework this patch once the mailbox driver
migration is finalized.

Regards,
Vaibhav 
