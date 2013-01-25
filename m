From: xiechao.linux@gmail.com (chao xie)
Date: Fri, 25 Jan 2013 09:57:52 +0800
Subject: [V5 PATCH 07/26] usb: gadget: mv_udc: make mv_udc depends on
 ARCH_MMP or ARCH_PXA
In-Reply-To: <20130124090849.GE27304@arwen.pp.htv.fi>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
 <1359009530-28182-8-git-send-email-chao.xie@marvell.com>
 <20130124090849.GE27304@arwen.pp.htv.fi>
Message-ID: <CAK9wHMR4OH9hxfE31XHZvPVh+wfK7eDTqS-mL7Gmye1hzo5ScQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/24 Felipe Balbi <balbi@ti.com>:
> Hi,
>
> On Thu, Jan 24, 2013 at 01:38:31AM -0500, Chao Xie wrote:
>> Only ARCH_PXA and ARCH_MMP will use mv_udc.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>
> NAK, you should fix your transceiver dependency. I want these gadget
> drivers to compile cleanly on all arches so we make proper use of
> linux-next. I have applied up to previous patch in this series and I
> won't go any further. The rest will be delayed for v3.10
>
> sorry
>
> --
> balbi

I see. I will remove this patch. In fact, I have modified the dependency, so
without this patch, the reset of patches can still be compiled successully.
So when is the next merge? Need i re-send the rest of patches?
There are some feedbacks about device tree, and I will seperate the
device tree part from the
patche series. i do not want to post a big set of patches only with
modification to device tree part.

Thanks.

Chao
