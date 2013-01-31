From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 31 Jan 2013 11:17:50 +0000
Subject: [RFC v2 12/18] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clockevent device
In-Reply-To: <51095C7A.9080904@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-13-git-send-email-vaibhav.bedia@ti.com>
 <50EC37FE.705@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ECE0D51@DBDE01.ent.ti.com>
 <50F846D7.8060509@ti.com> <50F8DCD7.707@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ECF0B60@DBDE01.ent.ti.com>
 <51095C7A.9080904@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED05777@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 23:16:34, Hunter, Jon wrote:
> 
> Ok fair enough. By the way, I posted a patch today [1] that will use the
> hwmod name as the clockevent timer name. Care to try on top of that
> patch and then we can eliminate the sprintf.
> 

Thanks. Will try it out later today.

Regards,
Vaibhav
