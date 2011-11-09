From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 9 Nov 2011 11:29:18 +0200
Subject: [RFC 4/5] ARM: OMAP3: bind omap3isp_device to its iommu device
In-Reply-To: <201111091017.18860.laurent.pinchart@ideasonboard.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
 <1316948337-7924-5-git-send-email-ohad@wizery.com>
 <201111091017.18860.laurent.pinchart@ideasonboard.com>
Message-ID: <CAK=WgbbizCd5ZBjyk=sukWtR6j1vVv+1Jc-QRzfppPCaQ+67HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2011 at 11:17 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Ohad,
>
> On Sunday 25 September 2011 12:58:56 Ohad Ben-Cohen wrote:
>> Bind OMAP3's isp device to the isp's dedicated iommu, by setting
>> the device's archdata iommu member.
>>
>> This way omap3isp will be able to use the generic IOMMU API without
>> having to call any omap-specific binding method.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, Laurent!

Tony, can you please Ack the OMAP parts of this patch set:

https://lkml.org/lkml/2011/9/25/44 (patch 3/5)
https://lkml.org/lkml/2011/9/25/46 (patch 4/5)
https://lkml.org/lkml/2011/9/25/45 (patch 5/5)

With this in hand, generic iommu users will now work on OMAP platforms
too (without calling any omap-specific API).

Thanks,
Ohad.
