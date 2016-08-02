From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 2 Aug 2016 11:45:10 +0530
Subject: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
In-Reply-To: <87oa5cxq3l.fsf@belgarion.home>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <87oa5cxq3l.fsf@belgarion.home>
Message-ID: <57A03A6E.3010905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 02 August 2016 12:40 AM, Robert Jarzmik wrote:
> Kishon Vijay Abraham I <kishon@ti.com> writes:
> 
>> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
>> Fix it from getting redundantly selected in all
>> ARCH_MULTIPLATFORM based machines.
> 
> If that's the purpose, then CM-X255 and CM-X270 don't fall in that category, as
> they are not part of ARCH_MULTIPLATFORM nor ready for it AFAIK. So the change
> below shouldn't be done according to the commit message.

yeah, got that now. Looks like ARCH_PXA is not converted to multiplatform. Will
fix and repost the series.

Thanks
Kishon
