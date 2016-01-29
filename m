From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 29 Jan 2016 18:58:40 +0100
Subject: Exynos Snow board display regression
In-Reply-To: <56AB9EDF.2050401@osg.samsung.com>
References: <CAOMqctT2dAQERos8bhrtVirF7ma4onq+UUS2ks-86LJ_mVDU6g@mail.gmail.com>
 <56AB9EDF.2050401@osg.samsung.com>
Message-ID: <CAOMqctRZC4T=wnN3qzZSOk-TP_uyFZNh7mqpfe71j=rOBUFn-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2016 at 18:18, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Michal,
>
> On 01/29/2016 02:07 PM, Michal Suchanek wrote:
>>
>> Hello,
>>
>> after  commit a9fa852886fd5a7ccec3b7e9eff75f85072f009c
>>
>> display no longer works on the Snow board. The built-in panel is no
>> longer probed.
>>
> Yes, I noticed the same and posted a fix some hours ago:
>
> https://lkml.org/lkml/2016/1/29/355
>
Tested-by: Michal Suchanek <hramrach@gmail.com>

on that patch.

Thanks

Michal
