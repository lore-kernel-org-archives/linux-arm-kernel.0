From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 9 Nov 2011 10:50:30 +0200
Subject: [RFC 5/5] iommu/omap: eliminate the public
 omap_find_iommu_device() method
In-Reply-To: <201109271346.13791.laurent.pinchart@ideasonboard.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
 <1316948337-7924-6-git-send-email-ohad@wizery.com>
 <201109271346.13791.laurent.pinchart@ideasonboard.com>
Message-ID: <CAK=WgbZaZTT=PsrvY8QTypuViknCK=APHogZLg5SjSN3_C=odw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Sep 27, 2011 at 2:46 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Sunday 25 September 2011 12:58:57 Ohad Ben-Cohen wrote:
>> Eliminate the public omap_find_iommu_device() method, and don't
>> expect clients to provide the omap_iommu handle anymore.
>>
>> Instead, OMAP's iommu driver should now utilize dev_archdata's private
>> iommu extension to be able to access the required iommu information.
>>
>> Update omap3isp appropriately.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>
> For the OMAP3 ISP driver,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks !

Can you please also ack the 4th patch in this series (that's the part
the makes this fifth patch possible):

https://lkml.org/lkml/2011/9/25/46

I could then ask Tony to Ack it so we could merge this via the iommu tree.

Thanks,
Ohad.
