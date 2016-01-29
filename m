From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 29 Jan 2016 14:18:23 -0300
Subject: Exynos Snow board display regression
In-Reply-To: <CAOMqctT2dAQERos8bhrtVirF7ma4onq+UUS2ks-86LJ_mVDU6g@mail.gmail.com>
References: <CAOMqctT2dAQERos8bhrtVirF7ma4onq+UUS2ks-86LJ_mVDU6g@mail.gmail.com>
Message-ID: <56AB9EDF.2050401@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Michal,

On 01/29/2016 02:07 PM, Michal Suchanek wrote:
> Hello,
>
> after  commit a9fa852886fd5a7ccec3b7e9eff75f85072f009c
>
> display no longer works on the Snow board. The built-in panel is no
> longer probed.
>
> The commit *supposedly* provides for backwards compatibility and at
> first glance only new options for probing the panel are added.
>
> However, reverting the commit on top of 4.5-rc1 gives working display
> again so there is probably some subtle non-obvious catch in the logic.
>
> Any ideas what might go wrong here?
>

Yes, I noticed the same and posted a fix some hours ago:

https://lkml.org/lkml/2016/1/29/355
  
> Thanks
>
> Michal
>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
