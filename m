From: lho@apm.com (Loc Ho)
Date: Mon, 24 Feb 2014 22:08:57 -0800
Subject: [PATCH v13 3/3] arm64: Add APM X-Gene SoC AHCI SATA host
 controller DTS entries
In-Reply-To: <530C302A.5070809@ti.com>
References: <1393221265-13057-1-git-send-email-lho@apm.com>
 <1393221265-13057-2-git-send-email-lho@apm.com>
 <1393221265-13057-3-git-send-email-lho@apm.com>
 <1393221265-13057-4-git-send-email-lho@apm.com>
 <20140224183218.GB2522@htj.dyndns.org>
 <CAPw-ZT=CNdGn_iPp+jJbymvgBTNpXe1nCLeNwPWBdD3AAnHE6A@mail.gmail.com>
 <530C302A.5070809@ti.com>
Message-ID: <CAPw-ZTmM0G4-RXBMwxCXh32v8WpEv94A5+QdsQs40tmBy6DRkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon/Tejun,

>>     > Signed-off-by: Loc Ho <lho at apm.com <mailto:lho@apm.com>>
>>     > Signed-off-by: Tuan Phan <tphan at apm.com <mailto:tphan@apm.com>>
>>     > Signed-off-by: Suman Tripathi <stripathi at apm.com <mailto:stripathi@apm.com>>
>>
>>     This doesn't apply cleanly to libata/for-3.15.  How should this be
>>     routed?
>>
>>
>> You need to apply the corresponding PHY driver as well. Are you taken the
>> corresponding PHY driver into your libata tree? If not, we will need to route
>> to Kishon generic PHY framework tree. I include Kishon Vijay Abraham to this
>> email thread.
>
> I prefer dt entry go via dt maintainer. However I can add my Acked-by for the
> dt patches if you can copy me in those patches.

The dt email is cc'ed in the patch. Do I need to do anything more here?

>> Kishon,
>>
>> Do I need to re-send my SATA PHY driver to you as I had being posting them to
>> the scsi/arm mailing list?
>
> Yes please.

Okay... I will re-post the PHY to you and linux-kernel at vger.kernel.org.

-Loc
